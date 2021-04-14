import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/bloc/product_bloc/product_bloc.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/core/screen/all_product.dart';
import 'package:mobox/core/widget/error_card.dart';
import 'package:mobox/core/widget/product_card.dart';

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
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<ProductBloc>(context),
                        child: AllProducts()),
                    settings: RouteSettings(arguments: title),
                  ),
                ),
                child: Text('MORE'),
              ),
            ],
          ),
        ),
        Flexible(
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (withReTryButton && index >= productList.length)
                return ErrorCard(
                  () => context.read<ProductBloc>().add(ProductLoadRetried()),
                );
              return ProductCard(product: productList[index]);
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
