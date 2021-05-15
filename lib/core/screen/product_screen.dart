import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mobox/core/bloc/product_bloc/product_bloc.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/core/widget/rating_bar.dart' as customRating;
import 'package:flutter_rating_bar/flutter_rating_bar.dart' as flutterRate;
import 'package:mobox/core/widget/sale_off.dart';

class ProductScreen extends StatelessWidget {
  final Product product;

  const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: FittedBox(
              child: Text(
                product.storeName,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              // titlePadding: EdgeInsets.zero,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8, bottom: 2),
                    child: BlocBuilder<ProductBloc, ProductState>(
                      buildWhen: (previous, current) =>
                          current is ProductRateSuccess,
                      builder: (context, state) {
                        if (state is ProductRateSuccess) {
                          return flutterRate.RatingBar.builder(
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            glow: false,
                            itemSize: 16.0,
                            initialRating: state.newProductRateFromAPI,
                            onRatingUpdate: (_) {},
                            ignoreGestures: true,
                          );
                        }
                        return flutterRate.RatingBar.builder(
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          glow: false,
                          itemSize: 16.0,
                          initialRating: product.rate,
                          onRatingUpdate: (_) {},
                          ignoreGestures: true,
                        );
                      },
                    ),
                  ),
                ],
              ),
              collapseMode: CollapseMode.parallax,
              stretchModes: [StretchMode.zoomBackground, StretchMode.fadeTitle],
              background: Hero(
                tag: product.id,
                child: Image.asset(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Flex(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    direction: Axis.horizontal,
                    children: [
                      Flexible(
                        flex: 1,
                        child: SaleOff(
                          productScreen: true,
                          price: product.price,
                          sale: product.sale,
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      Flexible(
                        flex: 0,
                        child: BlocConsumer<ProductBloc, ProductState>(
                          listenWhen: (previous, current) =>
                              current is ProductRateSuccess ||
                              current is ProductRateFailure,
                          listener: (context, state) {
                            var _message = '';
                            if (state is ProductRateSuccess) {
                              _message = 'thanks for your feedback';
                            } else if (state is ProductRateFailure) {
                              _message =
                                  'some thing went wrong try again later!';
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(_message)));
                          },
                          buildWhen: (previous, current) =>
                              current is ProductRateSuccess ||
                              current is ProductRateFailure,
                          builder: (context, state) {
                            double? _myRate = product.myRate;
                            if (state is ProductRateSuccess) {
                              _myRate = state.newUserRate;
                            } else if (state is ProductRateFailure) {
                              _myRate = product.myRate;
                            }
                            return customRating.RatingBar(
                              immutable: false,
                              product:product,
                              rate: _myRate,
                            );
                          },
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverFillRemaining(
              child: Text.rich(
                TextSpan(
                  text: 'Description:\n\n',
                  style: Theme.of(context).textTheme.subtitle2,
                  children: [
                    TextSpan(
                      text: product.description,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                softWrap: true,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO add to cart function
        },
        child: Icon(Icons.add_shopping_cart),
      ),
    );
  }
}