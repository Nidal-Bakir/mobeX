import 'package:mobox/core/model/store_model.dart';

abstract class FollowListLocalDataSource {
  void appendCachedOrders(Store store);

  Stream<Store> getLocalCachedPurchasedOrders();
}

class FollowListLocalDataSourceImpl extends FollowListLocalDataSource {
  final List<Store> _storeCache = [];

  @override
  void appendCachedOrders(Store store) => _storeCache.add(store);

  @override
  Stream<Store> getLocalCachedPurchasedOrders() =>
      Stream.fromIterable(_storeCache);
}
