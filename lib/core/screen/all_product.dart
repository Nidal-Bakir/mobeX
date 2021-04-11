import 'package:flutter/material.dart';
import 'package:mobox/core/bloc/product_bloc/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/widget/no_data.dart';
import 'package:mobox/core/widget/products_grid.dart';

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
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadSuccess) {
            return ProductsGrid(products: state.productList);
          } else if (state is ProductLoadFailure) {
            return ProductsGrid(
              products: state.productList,
              withReTryButton: true,
              onRetry: () =>
                  context.read<ProductBloc>().add(ProductReRequested()),
            );
          } else if (state is ProductNoData) {
            return NoData(
              vertical: true,
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
