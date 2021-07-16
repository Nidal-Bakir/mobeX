import 'package:mobox/core/model/order_item.dart';
import 'package:mobox/features/purchase_orders/data/model/purchaser_info.dart';

class PurchaseOrder extends OrderItem {
  final DateTime orderTime;
  final int orderId;
  final PurchaserInfo purchaserInfo;

  PurchaseOrder(
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
      required int quantity,
      required OrderItemState orderItemState,
      required this.purchaserInfo,
      required this.orderTime,
      required this.orderId})
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
            orderItemState: orderItemState,
            quantity: quantity);

  @override
  Map<String, dynamic> toMap() => super.toMap()
    ..addAll({
      'order_date': orderTime,
      'order_no': orderId,
      "Purchaser_info": purchaserInfo.toMap()
    });

  @override
  List<Object?> get props => [
        orderId,
        orderTime,
        ...purchaserInfo.props,
        ...super.props,
      ];

  @override
  OrderItem copyWithNewOrderState({required OrderItemState orderItemState}) {
    return PurchaseOrder(
      orderItemState: orderItemState,
      quantity: quantity,
      storeName: storeName,
      storeId: storeId,
      rate: rate,
      price: price,
      myRate: myRate,
      imageUrl: imageUrl,
      id: id,
      description: description,
      sale: sale,
      title: title,
      orderTime: orderTime,
      orderId: orderId,
      purchaserInfo: purchaserInfo,
    );
  }

  factory PurchaseOrder.fromMap(Map<String, dynamic> jsonMap) {
    return PurchaseOrder(
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
      quantity: jsonMap['quantity'] as int,
      orderItemState: OrderItemState.values.firstWhere((element) =>
          jsonMap['item_state'] == element.toString().split('.')[1]),
      orderTime: DateTime.parse(jsonMap['order_date']),
      orderId: jsonMap['order_no'] as int,
      purchaserInfo: PurchaserInfo.formJson(jsonMap['Purchaser_info'] ),
    );
  }
}
