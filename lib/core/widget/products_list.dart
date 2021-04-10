import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/bloc/product_bloc/product_bloc.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/core/widget/error_cart.dart';
import 'package:mobox/core/widget/product_cart.dart';

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
    return Flex(
      direction: Axis.vertical,
      children: [
        Flexible(
          flex: 0,
          child: Row(
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
        ),
        Flexible(
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (withReTryButton && index >= productList.length)
                return ErrorCart(
                  () => context.read<ProductBloc>().add(ProductReRequested()),
                );
              return ProductCart(product: productList[index]);
            },
            itemCount:
                withReTryButton ? productList.length + 1 : productList.length,
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }
}
