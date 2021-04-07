import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/features/home_feed/bloc/ad_bloc/ad_bloc.dart';
import 'package:mobox/features/home_feed/presentation/widget/ad_widget.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var list = _generatore();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AdBloc>(
          create: (context) => GetIt.I(),
        )
      ],
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AdList(),
          ),
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 24),
          //     child: ProductsList(
          //       title: 'Offers from stores you like',
          //       products: list,
          //     ),
          //   ),
          // ),
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 16.0, top: 32, bottom: 16),
          //     child: Text(
          //       'New from stores you like',
          //       style: Theme.of(context).textTheme.headline6,
          //     ),
          //   ),
          // ),
          // SliverGrid(
          //   delegate: SliverChildBuilderDelegate((_, int index) {
          //     return ProductCart(product: list[index]);
          //   }),
          //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //     maxCrossAxisExtent: 200,
          //     crossAxisSpacing: 8,
          //     mainAxisSpacing: 16,
          //   ),
          // )
        ],
      ),
    );
  }

  List<Product> _generatore() {
    return List.generate(
      20,
      (index) => Product(
          id: index,
          title: 'title$index',
          storeName: 'storeName$index',
          imageUrl: index.isEven
              ? 'assets/images/productimg.png'
              : 'assets/images/productimg2.png',
          price: double.tryParse(
                  (Random().nextDouble() * 100).toStringAsFixed(2)) ??
              9.99,
          sale: 4.99,
          rate: 3.5),
    );
  }
}
