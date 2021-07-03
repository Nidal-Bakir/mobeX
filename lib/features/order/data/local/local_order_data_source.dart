import 'package:mobox/features/order/data/models/order.dart';
import 'package:mobox/features/order/data/models/order_item.dart';

abstract class LocalOrderDataSource {
  Stream<Order> getCachedOrders();

  void updateOrderItemState(int orderId, int itemId, OrderItemState state);

  void appendCachedOrders(Order order);
}

class LocalOrderDataSourceImpl extends LocalOrderDataSource {
  final _cachedOrders = <Order>[];

  @override
  void appendCachedOrders(Order order) => _cachedOrders.add(order);

  @override
  Stream<Order> getCachedOrders() => Stream.fromIterable(_cachedOrders);

  @override
  void updateOrderItemState(int orderId, int itemId, OrderItemState state) {
    // get order index to insert the order replacement and delete it
    var orderIndex =
        _cachedOrders.indexWhere((order) => order.orderId == orderId);

    var cachedOrder = _cachedOrders[orderIndex];

    // get order item index to insert new one in the same position and delete the old one
    var itemIndex =
        cachedOrder.items.indexWhere((orderItem) => orderItem.id == itemId);

    // new order item clone with new state
    var newOrderItemWithNewState = cachedOrder.items[itemIndex]
        .copyWithNewOrderState(orderItemState: state);

    // the new order items that will replace the old one
    var newOrderItems = List.of(cachedOrder.items
      ..removeAt(itemIndex)
      ..insert(itemIndex, newOrderItemWithNewState));

    // new order that will replace the old one in the cache
    var newOrder = cachedOrder.copyWithNewItems(newOrderItems);

    _cachedOrders
      ..removeAt(orderIndex)
      ..insert(orderIndex, newOrder);
  }
}
