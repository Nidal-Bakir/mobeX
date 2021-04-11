import 'package:flutter/material.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/core/widget/product_card.dart';

class ProductsGrid extends StatelessWidget {
  final List<Product> products;
  final bool withReTryButton;
  final Function()? onRetry;

  const ProductsGrid({
    Key? key,
    required this.products,
    this.withReTryButton = false,
    this.onRetry,
  })  : assert(onRetry == null && !withReTryButton),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: withReTryButton ? products.length + 1 : products.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 8,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        if (withReTryButton && index >= products.length) {
          return TextButton(
            onPressed: onRetry,
            child: Text('Retry'),
            style: Theme.of(context).textButtonTheme.style,
          );
        }
        return ProductCard(
          product: products[index],
        );
      },
    );
  }
}
