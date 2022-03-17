import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/auth/bloc/auth/auth_bloc.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/core/widget/animated_floating_action_button.dart';
import 'package:mobox/core/widget/sale_off.dart';

class ProductScreen extends StatelessWidget {
  final Product product;

  const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _userProfile =
        (context.read<AuthBloc>().state as AuthLoadUserProfileSuccess)
            .userProfile;
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            actions: [
              PopupMenuButton<int>(
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<int>>[
                    _userProfile.userName == product.storeId
                        ? PopupMenuItem<int>(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            child: Text('Manage this product'),
                            height: 15,
                            value: 0,
                          )
                        : PopupMenuItem<int>(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            child: Text('Open owner store'),
                            height: 15,
                            value: 1,
                          ),
                  ];
                },
                onSelected: (index) {
                  if (index == 0) {
                    Navigator.of(context)
                        .pushNamed<bool>('/product-manage', arguments: product)
                        .then((state) {
                      if (state != null) Navigator.of(context).pop();
                    });
                  } else {
                    Navigator.of(context).pushNamed('/store-screen',
                        arguments: [null, product.storeId]);
                  }
                },
              )
            ],
            title: FittedBox(
              child: Text(
                product.storeName,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            expandedHeight: MediaQuery.of(context).size.height * 0.6,
            pinned: true,
            stretch: true,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                var top = constraints.biggest.height;
                var oldRange = (320.0 - 80.0);
                var newRange = (1.0 - 0.0);
                var newValue = (((top - 80.0) * newRange) / oldRange) + 0.0;
                return FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  stretchModes: [
                    StretchMode.zoomBackground,
                    StretchMode.fadeTitle
                  ],
                  background: Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Hero(
                      tag: product.id,
                      child: Image.asset(
                        product.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
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
                        flex: 3,
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
      floatingActionButton: product.storeId == _userProfile.userName
          ? Container()
          : AnimatedAddToCartFAB(product: product),
    );
    //   Icon(Icons.add_shopping_cart)
  }
}
