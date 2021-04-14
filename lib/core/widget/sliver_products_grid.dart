import 'package:flutter/material.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/core/widget/product_card.dart';

class SliverProductsGrid extends StatelessWidget {
  final List<Product> productList;

  const SliverProductsGrid({
    Key? key,
    required this.productList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 8,
        mainAxisSpacing: 16,
      ),
      delegate: SliverChildBuilderDelegate(
        (_, int index) => ProductCard(product: productList[index]),
        childCount: productList.length,
      ),
    );
  }
}
