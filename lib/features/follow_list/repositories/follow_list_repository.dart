import 'package:mobox/core/model/store_model.dart';
import 'package:mobox/features/follow_list/data/local/data_sources/follow_list_local_data_source.dart';
import 'package:mobox/features/follow_list/data/remote/data_sources/follow_list_remote_data_source.dart';

class FollowListRepository {
  final FollowListRemoteDataSource _remoteDataSource;
  final FollowListLocalDataSource _localDataSource;

  FollowListRepository(this._remoteDataSource, this._localDataSource);

  Stream<Store> getStoresTheUserFollow() async* {
    yield* _localDataSource.getLocalCachedPurchasedOrders();

    var remoteStream =
        _remoteDataSource.getStoresTheUserFollow().asBroadcastStream();

    remoteStream.listen((event) {
      _localDataSource.appendCachedOrders(event);
    });

    yield* remoteStream;
  }
}
