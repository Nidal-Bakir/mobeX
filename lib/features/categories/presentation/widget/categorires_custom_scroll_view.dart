import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobox/core/bloc/product_bloc/product_bloc.dart';
import 'package:mobox/core/widget/Product_list_widget.dart';
import 'package:mobox/core/widget/retry_button.dart';
import 'package:mobox/features/categories/bloc/categories_bloc.dart';

class CategoriesCustomScrollView extends StatelessWidget {
  final List<String> categoriesList;
  final bool withRetryButton;

  const CategoriesCustomScrollView({
    Key? key,
    required this.categoriesList,
    this.withRetryButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            (sliverContext, index) => BlocProvider<ProductBloc>(
              create: (sliverContext) =>
                  GetIt.I.get<ProductBloc>(param1: categoriesList[index]),
              child: ProductList(title: categoriesList[index]),
            ),
            childCount: categoriesList.length,
          ),
          itemExtent: 250.0,
        ),
        if (withRetryButton)
          SliverToBoxAdapter(
            child: BlocProvider.value(
              value: context.read<CategoriesBloc>(),
              child: Center(
                  child: RetryTextButton(
                onClickCallback: () =>
                    context.read<ProductBloc>().add(ProductLoadRetried()),
              )),
            ),
          )
      ],
    );
  }
}
