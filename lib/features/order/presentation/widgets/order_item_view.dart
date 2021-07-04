import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/utils/global_function.dart';
import 'package:mobox/features/order/data/models/order_item.dart' as model;
import 'package:mobox/core/error/exception.dart';
import 'package:mobox/features/order/presentation/bloc/order_item_bloc/order_item_bloc.dart';

class OrderItemView extends StatelessWidget {
  const OrderItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderItemBloc, OrderItemState>(
      listenWhen: (previous, current) =>
          current is OrderItemMarkAsDeliveredSuccess ||
          current is OrderItemMarkAsDeliveredFailure,
      listener: (context, state) {
        var message = '';
        if (state is OrderItemMarkAsDeliveredSuccess) {
          message = 'Product marked as delivered';
        } else {
          message = 'Something want wrong!!';
        }

        showSnack(context, message);
      },
      builder: (context, state) {
        if (state is OrderItemMarkAsDeliveredInProgress) {
          return _Item(
            orderItem: state.orderItem,
            orderId: state.orderId,
            isMarkingInProgress: true,
          );
        }
        return _Item(orderItem: state.orderItem, orderId: state.orderId);
      },
    );
  }
}

class _Item extends StatelessWidget {
  final model.OrderItem orderItem;
  final bool isMarkingInProgress;
  final int orderId;

  const _Item({
    Key? key,
    required this.orderItem,
    this.isMarkingInProgress = false,
    required this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(orderItem.imageUrl),
        ),
        title: Text(
          orderItem.title,
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(fontWeight: FontWeight.w100),
        ),

        // isThreeLine: true,
        subtitle: orderItem.orderItemState == model.OrderItemState.Sent
            ? isMarkingInProgress
                ? LinearProgressIndicator()
                : Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        context.read<OrderItemBloc>().add(OrderItemDelivered(
                            orderId: orderId, itemId: orderItem.id));
                      },
                      child: Text('Mark as delivered'),
                      style: Theme.of(context).textButtonTheme.style?.copyWith(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.zero)),
                    ),
                  )
            : Text(
                orderItem.orderItemState.toString().split('.')[1],
              ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text((orderItem.sale ?? orderItem.price).toStringAsFixed(2) +
                ' X${orderItem.quantity}'),
            // total price
            Text(((orderItem.sale ?? orderItem.price) * orderItem.quantity)
                .toStringAsFixed(2))
          ],
        ));
  }
}
