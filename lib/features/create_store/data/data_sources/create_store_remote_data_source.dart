import 'package:mobox/core/model/editable_profile_info.dart';
import 'package:http/http.dart' as http;
import 'package:mobox/core/utils/api_urls.dart';
import 'package:mobox/core/utils/global_function.dart';

abstract class CreateStoreRemoteDataSource {
  /// Upload a photo to the server with data as headers.
  ///
  /// Takes [profileInfo] hold the store information.
  ///
  /// Returns True if the upload was successful.
  Future<bool> createStore(EditableProfileInfo profileInfo);
}

class CreateStoreRemoteDataSourceImpl extends CreateStoreRemoteDataSource {
  final http.Client _client;

  /// user token
  final String _token;

  CreateStoreRemoteDataSourceImpl(this._token, this._client);

  @override
  Future<bool> createStore(EditableProfileInfo profileInfo) async {
    // TODO remove this return
    return true;
    return await uploadImageWithDataHeader(
        token: _token,
        endPoint: ApiUrl.BASE_URL + '/store',
        imagePath: profileInfo.profileImagePath,
        headers: profileInfo.toMap()..remove("profile_image"),
        method: 'PATCH');
  }
}
