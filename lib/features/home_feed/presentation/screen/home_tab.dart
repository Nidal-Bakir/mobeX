import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobox/core/bloc/product_bloc/product_bloc.dart';
import 'package:mobox/core/utils/global_function.dart';

import 'package:mobox/core/widget/Product_list_widget.dart';
import 'package:mobox/features/home_feed/presentation/widget/new_products_sliver_grid.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<ProductBloc>(param1: 'newProducts'),
      child: Builder(
        builder: (builderContext) => NotificationListener<ScrollNotification>(
          onNotification: (notification) => notificationListener(
            notification: notification,
            onNotify: () =>
                builderContext.read<ProductBloc>().add(ProductMoreDataLoaded()),
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: BlocProvider(
                  create: (context) => GetIt.I.get<ProductBloc>(param1: 'ad'),
                  child: ProductList(
                    title: 'Ad',
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: BlocProvider(
                  create: (context) =>
                      GetIt.I.get<ProductBloc>(param1: 'offers'),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: ProductList(
                      title: 'Offers from stores you follow',
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 32, bottom: 16),
                  child: Text(
                    'New from stores you follow',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              NewProductSliverGrid(),
              SliverToBoxAdapter(
                child: Builder(
                  builder: (context) => BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductMoreInProgress)
                        return LinearProgressIndicator();
                      else if (state is ProductLoadFailure)
                        return Center(
                          child: TextButton(
                            onPressed: () => context
                                .read<ProductBloc>()
                                .add(ProductLoadRetried()),
                            child: Text('RETRY'),
                            style: Theme.of(context).textButtonTheme.style,
                          ),
                        );
                      return Container();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
