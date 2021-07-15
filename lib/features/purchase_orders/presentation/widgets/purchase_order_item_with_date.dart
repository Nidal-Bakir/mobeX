import 'package:flutter/material.dart';
import 'package:mobox/features/purchase_orders/presentation/widgets/purchase_order_item.dart';

class PurchaseOrderItemWithDate extends StatelessWidget {
  final DateTime orderDate;

  const PurchaseOrderItemWithDate({Key? key, required this.orderDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 16,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            orderDate.toString(),
            style: TextStyle(
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        PurchaseOrderItem(),
      ],
    );
  }
}
