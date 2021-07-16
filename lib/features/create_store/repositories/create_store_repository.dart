import 'package:mobox/core/model/editable_profile_info.dart';
import 'package:mobox/features/create_store/data/data_sources/create_store_remote_data_source.dart';

class CreateStoreRepository {
  final CreateStoreRemoteDataSource _remoteDataSource;

  const CreateStoreRepository(this._remoteDataSource);

  Future<bool> createStore(EditableProfileInfo profileInfo) =>
      _remoteDataSource.createStore(profileInfo);
}
