import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/error/exception.dart';
import 'package:mobox/core/model/order_item.dart';
import 'package:mobox/core/utils/global_function.dart';
import 'package:mobox/features/purchase_orders/data/model/purchase_orders.dart';
import 'package:mobox/features/purchase_orders/presentation/manager/purchase_order_bloc/purchase_order_bloc.dart';

class PurchaseOrderItem extends StatelessWidget {
  const PurchaseOrderItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PurchaseOrderBloc, PurchaseOrderState>(
      listenWhen: (previous, current) =>
          current is PurchaseOrderUpdateStateFailure ||
          current is PurchaseOrderUpdateStateSuccess,
      listener: (context, state) {
        var message = '';
        if (state is PurchaseOrderUpdateStateSuccess) {
          message =
              'order marked as ${state.purchaseOrder.getOrderItemState()}';
        } else {
          message = 'Something want wrong!!';
        }

        showSnack(context, message);
      },
      builder: (context, state) {
        if (state is PurchaseOrderUpdateStateSuccess ||
            state is PurchaseOrderUpdateStateFailure ||
            state is PurchaseOrderInitial) {
          return _Item(purchaseOrder: state.purchaseOrder);
        } else if (state is PurchaseOrderUpdateStateInProgress) {
          return _Item(
              purchaseOrder: state.purchaseOrder, inLoadingState: true);
        }

        throw UnHandledStateException(state);
      },
    );
  }
}

class _Item extends StatelessWidget {
  final inLoadingState;
  final PurchaseOrder purchaseOrder;
  static final _unChangeableOrderStateList = List.unmodifiable([
    OrderItemState.Rejected.getState(),
    OrderItemState.Sent.getState(),
    OrderItemState.Delivered.getState()
  ]);

  const _Item(
      {Key? key, this.inLoadingState = false, required this.purchaseOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context)
          .pushNamed('/store-screen', arguments: [null, purchaseOrder.storeId]),
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: AssetImage(purchaseOrder.imageUrl),
      ),
      title: Text(
        purchaseOrder.title,
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(fontWeight: FontWeight.w100),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'To: ${purchaseOrder.storeName},\n Quantity: ${purchaseOrder.quantity}',
          ),
          if (inLoadingState) LinearProgressIndicator(),
          Divider()
        ],
      ),
      trailing: SizedBox(
        width: 100,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            style: TextStyle(
              color: Theme.of(context).accentColor,
            ),
            value: purchaseOrder.getOrderItemState(),
            onChanged: _unChangeableOrderStateList
                    .contains(purchaseOrder.getOrderItemState())
                ? null
                : (choices) {
                    if (choices != null &&
                        choices != purchaseOrder.getOrderItemState()) {
                      context.read<PurchaseOrderBloc>().add(
                          PurchaseOrderStateUpdated(
                              purchaseOrder,
                              convertStringOrderStateToEnumObjectState(
                                  choices)));
                    }
                  },
            items: _stateChoices(purchaseOrder.getOrderItemState())
                .map<DropdownMenuItem<String>>(
                  (String choices) => DropdownMenuItem(
                    child: Text(choices),
                    value: choices,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

List<String> _stateChoices(String state) {
  final enumValueFromStringValue =
      convertStringOrderStateToEnumObjectState(state);

  switch (enumValueFromStringValue) {
    case OrderItemState.Hold:
      return [
        OrderItemState.Hold.getState(),
        OrderItemState.Accepted.getState(),
        OrderItemState.Rejected.getState(),
        OrderItemState.InProgress.getState(),
        OrderItemState.Sent.getState()
      ];

    case OrderItemState.Rejected:
    case OrderItemState.Delivered:
    case OrderItemState.Sent:
      return [state];

    case OrderItemState.Accepted:
      return [
        OrderItemState.Accepted.getState(),
        OrderItemState.InProgress.getState(),
        OrderItemState.Sent.getState()
      ];
    case OrderItemState.InProgress:
      return [
        OrderItemState.InProgress.getState(),
        OrderItemState.Sent.getState(),
      ];
  }
}
