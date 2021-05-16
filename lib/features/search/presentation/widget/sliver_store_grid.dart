import 'package:flutter/material.dart';
import 'package:mobox/features/search/data/model/store_model.dart';
import 'package:mobox/features/search/presentation/widget/store_card.dart';

class SliverStoresGrid extends StatelessWidget {
  final List<Store> storeList;

  const SliverStoresGrid({
    Key? key,
    required this.storeList,
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
            (_, int index) => StoreCard(store: storeList[index]),
        childCount: storeList.length,
      ),
    );
  }
}
