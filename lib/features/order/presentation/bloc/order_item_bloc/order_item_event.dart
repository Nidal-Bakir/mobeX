part of 'order_item_bloc.dart';

abstract class OrderItemEvent extends Equatable {
  const OrderItemEvent();
}
class OrderItemDelivered extends OrderItemEvent {
  final int orderId;
  final int itemId;

  const OrderItemDelivered({required this.orderId, required this.itemId});

  @override
  List<Object?> get props => [orderId, itemId];
}