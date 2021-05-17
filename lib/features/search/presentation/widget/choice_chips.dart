import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mobox/core/bloc/product_bloc/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/features/search/bloc/store_search_bloc.dart';
import 'package:mobox/features/search/util/search_value_state_provider.dart';

class ChoiceChips extends StatefulWidget {
  @override
  _ChoiceChipsState createState() => _ChoiceChipsState();
}

class _ChoiceChipsState extends State<ChoiceChips> {
  bool _storeIsSelected = false;
  bool _productIsSelected = true;
  bool _enablePriceRange = false;
  late final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _searchStateProv = context.read<SearchValueStateProvider>();
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ChoiceChip(
            labelStyle: TextStyle(fontSize: 14),
            label: Text('Stores'),
            selectedColor: Theme.of(context).accentColor,
            selected: _storeIsSelected,
            onSelected: (selected) {
              _searchStateProv.setSearchType(SearchType.Stores);

              if (!_storeIsSelected &&
                  _searchStateProv.getSearchTerms().isNotEmpty) {
                context.read<StoreSearchBloc>().add(StoreSearchLoaded(
                      storeName: _searchStateProv.getSearchTerms(),
                    ));
              }
              setState(() {
                _productIsSelected = false;
                _storeIsSelected = true;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ChoiceChip(
            labelStyle: TextStyle(fontSize: 14),
            label: Text('Products'),
            selected: _productIsSelected,
            onSelected: (selected) {
              _searchStateProv.setSearchType(SearchType.Products);
              if (!_productIsSelected &&
                  _searchStateProv.getSearchTerms().isNotEmpty) {
                context.read<ProductBloc>().add(
                      ProductsSearchLoaded(
                        productName: _searchStateProv.getSearchTerms(),
                        priceLessThenOrEqual: _enablePriceRange
                            ? _searchStateProv.getPriceLessThenOrEqual()
                            : null,
                      ),
                    );
              }
              setState(() {
                _productIsSelected = true;
                _storeIsSelected = false;
              });
            },
            selectedColor: Theme.of(context).accentColor,
          ),
        ),
        if (_productIsSelected)
          Checkbox(
            value: _enablePriceRange,
            onChanged: (isSelected) {
              if (isSelected ?? false) {
                _searchStateProv
                    .setPriceLessThenOrEqual(double.tryParse(_controller.text));
              } else {
                _searchStateProv.setPriceLessThenOrEqual(null);
              }
              setState(() {
                _enablePriceRange = isSelected ?? false;
              });
            },
          ),
        if (_productIsSelected)
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _controller,
              onChanged: (value) {
                _searchStateProv
                    .setPriceLessThenOrEqual(double.tryParse(value));
              },
              enabled: _enablePriceRange,
              style: Theme.of(context).textTheme.caption,
              decoration: InputDecoration(
                hintText: 'Less then or equal',
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
            ),
          )
      ],
    );
  }
}
