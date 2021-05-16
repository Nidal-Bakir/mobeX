import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobox/core/bloc/product_bloc/product_bloc.dart';
import 'package:mobox/features/search/bloc/store_search_bloc.dart';
import 'package:mobox/features/search/presentation/widget/choice_chips.dart';
import 'package:mobox/features/search/presentation/widget/product_search_result.dart';
import 'package:mobox/features/search/presentation/widget/search_fild.dart';
import 'package:mobox/features/search/presentation/widget/store_search_result.dart';
import 'package:mobox/features/search/util/search_value_state_provider.dart';
import 'package:provider/provider.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
            create: (context) => GetIt.I.get<ProductBloc>(param1: 'search')),
        BlocProvider<StoreSearchBloc>(
            create: (context) => GetIt.I.get<StoreSearchBloc>()),
      ],
      child: Scaffold(
          body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 112,
              titleSpacing: 0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Divider(thickness: 0.5),
                    ChoiceChips(),
                  ],
                ),
              ),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    padding: EdgeInsets.zero,
                    visualDensity:
                        VisualDensity.compact.copyWith(horizontal: -2),
                  ),
                  SearchField(),
                  SizedBox(width: 16)
                ],
              ),
              automaticallyImplyLeading: false,
            ),
          ];
        },
        body: Consumer<SearchValueStateProvider>(
          builder: (_, value, __) =>
              value.getSearchType() == SearchType.Products
                  ? ProductSearchResult()
                  : StoreSearchResult(),
        ),
      )),
    );
  }
}
