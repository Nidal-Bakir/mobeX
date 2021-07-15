import 'package:mobox/features/order/data/local/local_order_data_source.dart';
import 'package:mobox/features/order/data/models/order.dart';
import 'package:mobox/core/model/order_item.dart';
import 'package:mobox/features/order/data/remote/remote_order_data_source.dart';

class OrderRepository {
  final LocalOrderDataSource _local;
  final RemoteOrderDataSource _remote;

  OrderRepository(this._local, this._remote);

  Stream<Order> getStreamOfUserOrders() async* {
    yield* _local.getCachedOrders();

    var streamOfOrders = _remote.getOrdersStream().asBroadcastStream();

    streamOfOrders.listen((event) {
      _local.appendCachedOrders(event);
    });

    yield* streamOfOrders;
  }

  Future<bool> makeOrderItemAsDelivered(int orderId, int itemId) async {
    var isSuccess = await _remote.markOderItemAsDelivered(orderId, itemId);
    if (isSuccess)
      _local.updateOrderItemState(orderId, itemId, OrderItemState.Delivered);

    return isSuccess;
  }

  Future<List<Order>> getLocalCachedOrders() async =>
      await _local.getCachedOrders().toList();

  void addNewOrder(Order order) => _local.appendCachedOrders(order);
}
