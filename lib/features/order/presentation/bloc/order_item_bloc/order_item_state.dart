part of 'order_item_bloc.dart';

abstract class OrderItemState extends Equatable {
  final model.OrderItem orderItem;
  final int orderId;

  const OrderItemState(this.orderItem, this.orderId);

  @override
  List<Object> get props => [orderId, orderItem];
}

class OrderItemInitial extends OrderItemState {
  const OrderItemInitial(model.OrderItem orderItem, int orderId)
      : super(orderItem, orderId);
}

class OrderItemMarkAsDeliveredSuccess extends OrderItemState {
  const OrderItemMarkAsDeliveredSuccess(model.OrderItem orderItem, int orderId)
      : super(orderItem, orderId);
}

class OrderItemMarkAsDeliveredInProgress extends OrderItemState {
  const OrderItemMarkAsDeliveredInProgress(
      model.OrderItem orderItem, int orderId)
      : super(orderItem, orderId);
}

class OrderItemMarkAsDeliveredFailure extends OrderItemState {
  const OrderItemMarkAsDeliveredFailure(model.OrderItem orderItem, int orderId)
      : super(orderItem, orderId);
}
