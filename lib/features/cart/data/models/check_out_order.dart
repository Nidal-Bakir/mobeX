import 'package:equatable/equatable.dart';

import 'order_item.dart';

class CheckOutOrder extends Equatable {
  final List<OrderItem> items;
  final DateTime orderDate;

  CheckOutOrder.empty()
      : this.items = [],
        this.orderDate = DateTime.now();

  CheckOutOrder._({required this.items, required this.orderDate});

  Map<String, dynamic> toMap() => {
        'oder_date': orderDate.toString(),
        'items': items.map((e) => e.toMap()).toList()
      };

  @override
  List<Object?> get props => [items, orderDate];

  CheckOutOrder copyWith({List<OrderItem>? items, DateTime? orderDate}) =>
      CheckOutOrder._(
        items: items ?? this.items,
        orderDate: orderDate ?? this.orderDate,
      );
}
