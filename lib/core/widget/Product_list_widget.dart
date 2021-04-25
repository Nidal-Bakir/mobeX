import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/bloc/product_bloc/product_bloc.dart';
import 'package:mobox/core/widget/no_data.dart';
import 'package:mobox/core/widget/products_list.dart';

class ProductList extends StatefulWidget {
  final String title;

  ProductList({required this.title});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    context.read<ProductBloc>().add(ProductDataLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: BlocBuilder<ProductBloc, ProductState>(
        buildWhen: (previous, current) =>
            current is! ProductRateSuccess && current is! ProductRateFailure,
        builder: (context, state) {
          if (state is ProductLoadSuccess) {
            return ProductsList(
              title: '${widget.title}',
              productList: state.productList,
            );
          } else if (state is ProductLoadFailure) {
            return ProductsList(
              title: '${widget.title}',
              productList: state.productList,
              withReTryButton: true,
            );
          } else if (state is ProductNoData) {
            return NoData(
              title: '${widget.title}',
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
