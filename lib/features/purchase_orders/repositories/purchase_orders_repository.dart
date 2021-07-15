import 'package:mobox/core/model/order_item.dart';
import 'package:mobox/features/purchase_orders/data/local/purchase_orders_local_data_source.dart';
import 'package:mobox/features/purchase_orders/data/model/purchase_orders.dart';
import 'package:mobox/features/purchase_orders/data/remote/purchase_order_remote_data_source.dart';

class PurchaseOrdersRepository {
  final PurchaseOrdersRemoteDataSource _remoteDataSource;
  final PurchaseOrdersLocalDataSource _localDataSource;

  PurchaseOrdersRepository(PurchaseOrdersRemoteDataSource remoteDataSource,
      PurchaseOrdersLocalDataSource localDataSource)
      : this._remoteDataSource = remoteDataSource,
        this._localDataSource = localDataSource;

  Stream<PurchaseOrder> getLocalCachedPurchasedOrders() =>
      _localDataSource.getLocalCachedPurchasedOrders();

  Stream<PurchaseOrder> getPurchaseOrders() async* {
    yield* getLocalCachedPurchasedOrders();

    var purchaseOrdersStream = _remoteDataSource.getPurchaseOrders().asBroadcastStream();

    purchaseOrdersStream.listen((event) {
      _localDataSource.appendCachedOrders(event);
    });

    yield* purchaseOrdersStream;
  }

  Future<bool> updatePurchaseOrderState(
      PurchaseOrder purchaseOrder, OrderItemState newState) async {
    var isSuccess = await _remoteDataSource.updatePurchaseOrderState(
        purchaseOrder, newState);
    if (isSuccess) {
      _localDataSource.updateCachedPurchaseOrderItemState(
          purchaseOrder, newState);
      return isSuccess;
    }
    return isSuccess;
  }
}
