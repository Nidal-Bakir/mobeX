import 'package:mobox/core/model/order_item.dart';
import 'package:mobox/features/purchase_orders/data/model/purchase_orders.dart';

abstract class PurchaseOrdersLocalDataSource {
  Stream<PurchaseOrder> getLocalCachedPurchasedOrders();

  void updateCachedPurchaseOrderItemState(
      PurchaseOrder purchaseOrder, OrderItemState newState);

  void appendCachedOrders(PurchaseOrder purchaseOrder);
}

class PurchaseOrderLocalDataSourceImpl extends PurchaseOrdersLocalDataSource {
  final _cachedPurchasedOrders = <PurchaseOrder>[];

  @override
  Stream<PurchaseOrder> getLocalCachedPurchasedOrders() =>
      Stream.fromIterable(_cachedPurchasedOrders);

  @override
  void updateCachedPurchaseOrderItemState(
      PurchaseOrder purchaseOrder, OrderItemState newState) {
    // get PurchaseOrder index to insert the new PurchaseOrder replacement and delete it
    var purchaseOrderIndex = _cachedPurchasedOrders.indexWhere(
        (e) => purchaseOrder.id == e.id && purchaseOrder.orderId == e.orderId);

    // generate new Purchase order object from  existing one with new state
    var newPurchaseOrder = _cachedPurchasedOrders[purchaseOrderIndex]
        .copyWithNewOrderState(orderItemState: newState) as PurchaseOrder;

    _cachedPurchasedOrders
      ..removeAt(purchaseOrderIndex)
      ..insert(purchaseOrderIndex, newPurchaseOrder);
  }

  @override
  void appendCachedOrders(PurchaseOrder purchaseOrder) =>
      _cachedPurchasedOrders.add(purchaseOrder);
}
