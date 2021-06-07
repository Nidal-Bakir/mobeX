import 'package:mobox/core/data/store_data_source/remote/store_follow_remote_data_source.dart';
import 'package:mobox/features/search/data/model/store_model.dart';

class StoreRepository {
  final RemoteStoreDataSource remoteStoreDataSource;

  const StoreRepository({required this.remoteStoreDataSource});

  Future<bool> getFollowStateForStore({required String storeUserName}) {
    return remoteStoreDataSource.getFollowStateForStore(
        storeUserName: storeUserName);
  }

  void setFollowStateForStore(
      {required String storeUserName, required bool followState}) {
    return remoteStoreDataSource.setFollowStateForStore(
        storeUserName: storeUserName, followState: followState);
  }
  Future<Store> getStoreInfoFromStoreUserName({required String storeUserName})async{
    return await remoteStoreDataSource.getStoreInfoFromStoreUserName(storeUserName:storeUserName);
  }
}
