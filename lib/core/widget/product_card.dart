import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/bloc/product_bloc/product_bloc.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/core/screen/product_screen.dart';
import 'package:mobox/core/widget/sale_off.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<ProductBloc>(),
          child: ProductScreen(product: product),
        ),
      )),
      child: ClipRRect(
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
                            child: Hero(
                          tag: product.id,
                          child: Image.asset(
                            product.imageUrl,
                            fit: BoxFit.cover,
                          ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${product.storeName}',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        Text(
                          product.rate.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    SaleOff(
                      productScreen: false,
                      sale: product.sale,
                      price: product.price,
                    ),
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
