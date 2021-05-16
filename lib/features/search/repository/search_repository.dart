
import 'package:mobox/features/search/data/remote_data_source/remote_search_data_source.dart';
import 'package:mobox/features/search/data/model/store_model.dart';

class SearchRepository {
  RemoteSearchDataSource _remoteSearchDataSource;

  SearchRepository({required RemoteSearchDataSource remoteSearchDataSource})
      : _remoteSearchDataSource = remoteSearchDataSource;

  Stream<Store> searchStoresByTitle(
          {required String storeName, required int paginationCount}) =>
      _remoteSearchDataSource.searchStoresByName(
          storeName: storeName, paginationCount: paginationCount);
}
