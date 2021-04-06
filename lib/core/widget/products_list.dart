import 'package:flutter/material.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/core/widget/product_cart.dart';

class ProductsList extends StatelessWidget {
  final String title;

  const ProductsList({Key? key, required this.title, required this.products})
      : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                '$title',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            TextButton(onPressed: () {}, child: Text('MORE')),
          ],
        ),
        Container(
          height: 180,
          child: ListView.builder(
            itemBuilder: (context, index) =>
                ProductCart(product: products[index]),
            itemCount: products.length,
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }
}
