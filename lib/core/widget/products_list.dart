import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/core/widget/error_cart.dart';
import 'package:mobox/core/widget/product_cart.dart';
import 'package:mobox/features/home_feed/bloc/ad_bloc/ad_bloc.dart';
import 'package:mobox/features/home_feed/bloc/offers/offers_bloc.dart';

class ProductsList extends StatefulWidget {
  final String title;
  final Stream<Product> productStream;

  ProductsList({
    Key? key,
    required this.title,
    required this.productStream,
  }) : super(key: key);

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  final productList = <Product?>[];
  late final sc = StreamController<Product>();
  late final StreamSubscription sub;

  @override
  void initState() {
    widget.productStream.pipe(sc);
    sub = sc.stream.listen((event) {
      setState(() {
        print(event);
        productList.add(event);
      });
    })
      ..onError((error) {
        setState(() {
          productList.add(null);
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    sub.cancel();
    sc.close();
    super.dispose();
  }

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
                '${widget.title}',
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
                if (index >= productList.length) return Container();
                if (productList[index] == null)
                  return ErrorCart(
                    () => context.read<AdBloc>().add(AdReRequested()),
                  );
                return ProductCart(product: productList[index]!);
              },
              itemCount: productList.length,
              scrollDirection: Axis.horizontal,
            ))
      ],
    );
  }
}
