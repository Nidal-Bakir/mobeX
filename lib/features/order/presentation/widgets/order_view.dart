import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobox/features/order/data/models/order.dart';
import 'package:mobox/features/order/presentation/bloc/order_item_bloc/order_item_bloc.dart';
import 'package:mobox/features/order/presentation/widgets/order_item_view.dart';

class OrderView extends StatelessWidget {
  final Order order;

  const OrderView({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      children: [
        for (int i = 0; i < order.items.length; i++)
          BlocProvider<OrderItemBloc>(
            create: (BuildContext context) =>
                GetIt.I.get(param1: order.items[i], param2: order.orderId),
            child: OrderItemView(),
          )
      ],
      title: Text(
        order.items.skip(1).fold<String>(
              order.items.first.title,
              (previousValue, element) => previousValue + ", " + element.title,
            ),
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Text(
        order.orderDate.toString(),
      ),
    );
  }
}
