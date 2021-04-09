
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/core/widget/error_cart.dart';
import 'package:mobox/core/widget/product_cart.dart';
import 'package:mobox/features/home_feed/bloc/ad_bloc/ad_bloc.dart';

class ProductsList extends StatelessWidget {
  final String title;
  final List<Product> productList;
  final bool withReTryButton;

  ProductsList({
    Key? key,
    required this.title,
    required this.productList,
    this.withReTryButton = false,
  }) : super(key: key);

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
            // height: 180,
            child: ListView.builder(
              itemBuilder: (context, index) {
                if (withReTryButton && index >= productList.length)
                  return ErrorCart(
                    () => context.read<AdBloc>().add(AdReRequested()),
                  );
                return ProductCart(product: productList[index]);
              },
              itemCount:
                  withReTryButton ? productList.length + 1 : productList.length,
              scrollDirection: Axis.horizontal,
            ))
      ],
    );
  }
}
