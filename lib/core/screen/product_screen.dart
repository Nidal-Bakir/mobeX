import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/core/widget/sale_off.dart';

class ProductScreen extends StatelessWidget {
  final Product? product;

  const ProductScreen({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _product = product;
    if (_product == null) {
      print(
          'product screen gets null reference from argument settings.parameter ');
      return Center(
        child: Text(
          'some thing went wong try later!',
          style: Theme.of(context).textTheme.headline6,
        ),
      );
    } else {
      return Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              title: FittedBox(
                child: Text(
                  _product.storeName,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              expandedHeight: MediaQuery.of(context).size.height * 0.5,
              pinned: true,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.zero,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8, bottom: 2),
                      child: Text(
                        _product.rate.toString(),
                      ),
                    ),
                  ],
                ),
                collapseMode: CollapseMode.parallax,
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle
                ],
                background: Hero(
                  tag: _product.id,
                  child: Image.asset(
                    _product.imageUrl,
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
                      _product.title,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          flex: 0,
                          child: Text(
                            'Description:',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                        Spacer(),
                        Flexible(
                          flex: 0,
                          child: SaleOff(
                            vertical: false,
                            price: _product.price,
                            sale: _product.sale,
                          ),
                        )
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
                child: Text(
                  _product.description,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyText1,
                  overflow: TextOverflow.fade,
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
}

