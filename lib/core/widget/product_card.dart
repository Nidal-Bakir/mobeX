import 'package:flutter/material.dart';
import 'package:mobox/core/model/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 150,
        child: Card(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned.fill(
                          child: Image.asset(
                        product.imageUrl,
                        fit: BoxFit.cover,
                      )),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          width: constraints.maxWidth,
                          color: Colors.black45,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              bottom: 1.0,
                              top: 1.0,
                            ),
                            child: Text(
                              '${product.title}',
                              style: Theme.of(context).textTheme.subtitle1,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${product.storeName}'),
                      Text('${product.price}'),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${product.rate}'),
                      Text('${product.sale}'),
                    ],
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
