import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/bloc/product_bloc/product_bloc.dart';
import 'package:mobox/core/widget/no_data.dart';
import 'package:mobox/core/widget/sliver_products_grid.dart';

class NewProductSliverGrid extends StatefulWidget {
  @override
  _NewProductSliverGridState createState() => _NewProductSliverGridState();
}

class _NewProductSliverGridState extends State<NewProductSliverGrid> {
  @override
  void initState() {
    context.read<ProductBloc>().add(ProductDataLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: (previous, current) =>
          current is! ProductRateSuccess && current is! ProductRateFailure,
      builder: (context, state) {
        if (state is ProductLoadSuccess) {
          return SliverProductsGrid(productList: state.productList);
        } else if (state is ProductLoadFailure) {
          return SliverProductsGrid(productList: state.productList);
        } else if (state is ProductMoreInProgress) {
          return SliverProductsGrid(productList: state.productList);
        } else if (state is ProductNoData) {
          return SliverToBoxAdapter(
            child: NoData(title: 'New from stores you follow'),
          );
        }
        return SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
