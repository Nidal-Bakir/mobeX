import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/core/widget/product_cart.dart';
import 'package:mobox/features/home_feed/bloc/ad_bloc/ad_bloc.dart';

class ProductsList extends StatelessWidget {
  final String title;
  final bool withRetryButton;

  const ProductsList(
      {Key? key,
      required this.title,
      required this.products,
      this.withRetryButton = false})
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
            itemBuilder: (context, index) {
              if (withRetryButton && index == products.length + 1) {
                return Container(
                  width: 150,
                  height: 200,
                  child: Center(
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/error-cloud.png'),
                          TextButton(
                            onPressed: () {
                              context.read<AdBloc>().add(AdReRequested());
                            },
                            child: Text('RETRY'),
                            style: Theme.of(context).textButtonTheme.style,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
              return ProductCart(product: products[index]);
            },
            itemCount: products.length,
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }
}
