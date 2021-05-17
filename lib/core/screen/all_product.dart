import 'package:flutter/material.dart';
import 'package:mobox/core/bloc/product_bloc/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/utils/global_function.dart';
import 'package:mobox/core/widget/no_data.dart';
import 'package:mobox/core/widget/retry_button.dart';
import 'package:mobox/core/widget/sliver_products_grid.dart';

class AllProducts extends StatefulWidget {
  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  void initState() {
    // the bloc will be passed by value (BP.value) when navigation to this screen
    // products and values depend on the bloc passed to this screen.
    context.read<ProductBloc>().add(ProductDataLoaded());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String title = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) => notificationListener(
            notification: notification,
            onNotify: () =>
                context.read<ProductBloc>().add(ProductMoreDataLoaded())),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(title),
              snap: true,
              floating: true,
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            BlocBuilder<ProductBloc, ProductState>(
              buildWhen: (previous, current) =>
                  current is! ProductRateSuccess &&
                  current is! ProductRateFailure,
              builder: (context, state) {
                if (state is ProductLoadSuccess) {
                  return SliverProductsGrid(productList: state.productList);
                } else if (state is ProductLoadFailure) {
                  return SliverProductsGrid(productList: state.productList);
                } else if (state is ProductMoreInProgress) {
                  return SliverProductsGrid(productList: state.productList);
                } else if (state is ProductNoData) {
                  return SliverFillRemaining(child: NoData(vertical: true));
                }
                return SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductMoreInProgress) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: LinearProgressIndicator(),
                    ),
                  );
                } else if (state is ProductLoadFailure) {
                  return RetryTextButton(
                    onClickCallback: () =>
                        context.read<ProductBloc>().add(ProductLoadRetried()),
                  );
                }
                return SliverToBoxAdapter(
                  child: Container(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
