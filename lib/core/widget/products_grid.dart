import 'package:flutter/material.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/core/widget/product_cart.dart';

class ProductsGrid extends StatelessWidget {
  final List<Product> products;
  final bool withErrorButton;
  final Function()? onRetry;

  const ProductsGrid({
    Key? key,
    required this.products,
    this.withErrorButton = false,
    this.onRetry,
  })  : assert(onRetry != null && withErrorButton),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: withErrorButton ? products.length + 1 : products.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 8,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        if (withErrorButton && index >= products.length) {
          return TextButton(
            onPressed: onRetry,
            child: Text('Retry'),
            style: Theme.of(context).textButtonTheme.style,
          );
        }
        return ProductCart(
          product: products[index],
        );
      },
    );
  }
}
