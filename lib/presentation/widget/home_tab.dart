import 'package:flutter/material.dart';
import 'package:mobox/presentation/widget/products_list.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: ProductsList(title: 'Ad'),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 24),
            child: ProductsList(title: 'Offers from stores you like'),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0,top:32,bottom: 16),
            child: Text(
              'New from stores you like',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate((_, int index) {
            return Container(
              color: Colors.green,
            );
          }),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 8,
            mainAxisSpacing: 24,
          ),
        )
      ],
    );
  }
}
