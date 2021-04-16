import 'package:flutter/material.dart';

class SaleOff extends StatelessWidget {
  final bool vertical;
  final double? sale;
  final double price;

  const SaleOff({
    Key? key,
    required this.vertical,
    required this.sale,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (vertical) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (sale != null)
            Text(
              sale.toString() + "\$",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          Text(
            price.toString() + "\$",
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  decoration: sale == null ? null : TextDecoration.lineThrough,
                  decorationColor: Theme.of(context).accentColor,
                  decorationThickness: 2.0,
                ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (sale != null)
            Text.rich(
              TextSpan(
                text: 'SALE OFF ',
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w900),
                children: [
                  TextSpan(
                    text: sale.toString() + "\$",
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: Theme.of(context).accentColor,
                          letterSpacing: -0.5,
                        ),
                  )
                ],
              ),
            ),
          Text(
            price.toString() + "\$",
            style: sale == null
                ? Theme.of(context).textTheme.headline6
                : Theme.of(context).textTheme.bodyText1?.copyWith(
                      decoration:
                          sale == null ? null : TextDecoration.lineThrough,
                      decorationColor: Theme.of(context).accentColor,
                      decorationThickness: 2.0,
                    ),
          ),
        ],
      );
    }
  }
}
