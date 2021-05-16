import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/bloc/product_bloc/product_bloc.dart';
import 'package:mobox/features/search/bloc/store_search_bloc.dart';
import 'package:mobox/features/search/util/search_value_state_provider.dart';

class SearchField extends StatefulWidget {
  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _searchStateProv = context.read<SearchValueStateProvider>();
    return Expanded(
      child: TextField(
        controller: _searchController,
        autofocus: true,
        onChanged: (value) {
          _searchStateProv.setSearchTerms(value);
          if (_searchStateProv.getSearchType() == SearchType.Products) {
            context.read<ProductBloc>().add(
                  value.trim() == ''
                      ? ProductSearchInitialed()
                      : ProductsSearchLoaded(
                          productName: _searchStateProv.getSearchTerms(),
                          priceLessThenOrEqual:
                              _searchStateProv.getPriceLessThenOrEqual(),
                        ),
                );
          } else {
            context.read<StoreSearchBloc>().add(value.trim() == ''
                ? StoreSearchInitialed()
                : StoreSearchLoaded(
                    storeName: _searchStateProv.getSearchTerms()));
          }
        },
        style: Theme.of(context).textTheme.bodyText2,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintText: 'search something ...',
          suffixIconConstraints: BoxConstraints.loose(Size(20, 20)),
          suffixIcon: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              _searchController.text = '';
              _searchStateProv.setSearchTerms('');
              if (_searchStateProv.getSearchType() == SearchType.Products) {
                context.read<ProductBloc>().add(ProductSearchInitialed());
              } else {
                context.read<StoreSearchBloc>().add(StoreSearchInitialed());
              }
            },
            icon: Icon(
              Icons.cancel_outlined,
              color: Colors.grey,
            ),
          ),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
