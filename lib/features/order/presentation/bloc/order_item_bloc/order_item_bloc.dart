import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobox/core/model/order_item.dart' as model;
import 'package:mobox/features/order/repositories/order_repository.dart';

part 'order_item_event.dart';

part 'order_item_state.dart';

class OrderItemBloc extends Bloc<OrderItemEvent, OrderItemState> {
  final OrderRepository _repository;
  final model.OrderItem _initValueForItem;
  final int _orderId;

  OrderItemBloc(
      {required OrderRepository repository,
      required model.OrderItem initValueForItem,
      required int orderId})
      : this._repository = repository,
        this._initValueForItem = initValueForItem,
        this._orderId = orderId,
        super(OrderItemInitial(initValueForItem, orderId));

  @override
  Stream<OrderItemState> mapEventToState(
    OrderItemEvent event,
  ) async* {
    if (event is OrderItemDelivered) {
      yield* _orderItemDeliveredHandle(event.itemId, event.orderId);
    }
  }

  Stream<OrderItemState> _orderItemDeliveredHandle(
      int itemId, int orderId) async* {
    yield OrderItemMarkAsDeliveredInProgress(_initValueForItem, _orderId);
    var isSuccess = await _repository.makeOrderItemAsDelivered(orderId, itemId);
    if (isSuccess)
      yield OrderItemMarkAsDeliveredSuccess(
          _initValueForItem.copyWithNewOrderState(
              orderItemState: model.OrderItemState.Delivered),
          _orderId);
    else
      yield OrderItemMarkAsDeliveredFailure(_initValueForItem, _orderId);
  }
}
