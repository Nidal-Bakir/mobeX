import 'package:equatable/equatable.dart';
import 'package:mobox/core/model/product_model.dart';

enum OrderItemState { Hold, Rejected, Accepted, InProgress, Sent, Delivered }

class OrderItem extends Product with EquatableMixin {
  final OrderItemState orderItemState;

  OrderItem(
      {required int id,
      required String title,
      required String storeName,
      required String storeId,
      required String imageUrl,
      required double price,
      required double? sale,
      required double rate,
      required double? myRate,
      required String description,
      required this.orderItemState})
      : super(
          id: id,
          title: title,
          storeName: storeName,
          storeId: storeId,
          imageUrl: imageUrl,
          price: price,
          sale: sale,
          rate: rate,
          myRate: myRate,
          description: description,
        );

  Product copyWithNewOrderState({required OrderItemState orderItemState}) {
    return OrderItem(
        orderItemState: orderItemState,
        storeName: storeName,
        storeId: storeId,
        rate: rate,
        price: price,
        myRate: myRate,
        imageUrl: imageUrl,
        id: id,
        description: description,
        sale: sale,
        title: title);
  }

  @override
  Map<String, dynamic> toMap() =>
      super.toMap()..putIfAbsent('order_item', () => orderItemState.toString());

  @override
  List<Object?> get props => [...super.props, orderItemState];

  factory OrderItem.fromMap(Map<String, dynamic> jsonMap) => OrderItem(
        id: jsonMap['id'] as int,
        title: jsonMap['product_name'],
        storeName: jsonMap['store_name'],
        storeId: jsonMap['store_no'],
        imageUrl: jsonMap['product_image'],
        myRate: double.tryParse(jsonMap['myRate'].toString()) == 0.0
            ? null
            : (jsonMap['myRate'] as double),
        description: jsonMap['description'] ?? '',
        price: jsonMap['product_price'] as double,
        sale: jsonMap['offer'] as double?,
        rate: jsonMap['rate'] as double,
        orderItemState: OrderItemState.values.firstWhere(
            (element) => jsonMap['item_state'] == element.toString()),
      );
}
