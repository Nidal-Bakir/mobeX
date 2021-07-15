import 'package:equatable/equatable.dart';
import 'package:mobox/core/model/order_item.dart';

class Order extends Equatable {
  final int orderId;
  final DateTime orderDate;
  final List<OrderItem> items;

  factory Order.fromMap(Map<String, dynamic> jsonMap) {
    return Order(
      items: jsonMap['items']
          .map<OrderItem>((item) => OrderItem.fromMap(item))
          .toList(),
      orderId: jsonMap['order_no'],
      orderDate: DateTime.parse(jsonMap['order_date']),
    );
  }

  Order({
    required this.orderId,
    required this.orderDate,
    required this.items,
  });

  @override
  List<Object?> get props => [orderId, orderDate, items];

  Order copyWithNewItems(List<OrderItem> newItems) =>
      Order(orderId: orderId, orderDate: orderDate, items: newItems);
}
