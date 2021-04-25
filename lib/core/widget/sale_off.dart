import 'package:flutter/material.dart';

class SaleOff extends StatelessWidget {
  final bool productScreen;
  final double? sale;
  final double price;

  const SaleOff({
    Key? key,
    required this.productScreen,
    required this.sale,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (productScreen) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (sale != null)
            Text(
              'SALE OFF',
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          if (sale != null)
            FittedBox(
                child: Text(
              sale.toString() + "\$".padLeft(2, '0'),
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Theme.of(context).accentColor,
                    letterSpacing: -0.5,
                  ),
            )),
          FittedBox(
            child: Text(
              price.toString() + "\$".padLeft(2, '0'),
              style: sale == null
                  ? Theme.of(context).textTheme.headline6
                  : Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Colors.grey[700],
                        decoration:
                            sale == null ? null : TextDecoration.lineThrough,
                        decorationColor: Theme.of(context).accentColor,
                        decorationThickness: 2.0,
                      ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (sale != null)
            FittedBox(
              child: Text(
                sale.toString() + "\$",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          FittedBox(
            child: Text(
              price.toString() + "\$",
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    decoration:
                        sale == null ? null : TextDecoration.lineThrough,
                    decorationColor: Theme.of(context).accentColor,
                    decorationThickness: 2.0,
                  ),
            ),
          ),
        ],
      );
    }
  }
}
