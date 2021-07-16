import 'dart:convert';

import 'package:mobox/core/model/user_profiel.dart';
import 'package:mobox/core/utils/api_urls.dart';
import 'package:mobox/core/model/editable_profile_info.dart';
import 'package:http/http.dart' as http;
import 'package:mobox/core/utils/global_function.dart';

abstract class RemoteProfileDataSource {
  Future<bool> changeProfileInfo(
      EditableProfileInfo newProfileInfo, UserProfile userProfile);
}

class RemoteProfileDataSourceImpl extends RemoteProfileDataSource {
  final http.Client client;

  /// user token
  final String token;

  RemoteProfileDataSourceImpl({required this.client, required this.token});

  @override
  Future<bool> changeProfileInfo(
      EditableProfileInfo newProfileInfo, UserProfile userProfile) async {
    Map<String, String> body =
        _getBodyMapFromProfileInfo(newProfileInfo, userProfile);

    // upload the changed data with the new photo using the headers
    if (newProfileInfo.profileImagePath != userProfile.profileImage) {
      var isSuccess = await uploadImageWithDataHeader(
          token: token,
          endPoint: ApiUrl.BASE_URL + '/user',
          imagePath: newProfileInfo.profileImagePath,
          headers: body,
          method: 'PATCH');

      return isSuccess;
    } else {
      // in case the photo dose not changed, patch the changed data (delta) to the server
      if (body.isNotEmpty) {
        var res = await client.patch(
            Uri.parse(
              ApiUrl.BASE_URL + '/user?token=$token',
            ),
            body: json.encode(body));

        if (res.statusCode != 200 || jsonDecode(res.body)['success'] == 'false')
          return false;
      }
    }

    return true;
  }

  Map<String, String> _getBodyMapFromProfileInfo(
      EditableProfileInfo profileInfo, UserProfile userProfile) {
    Map<String, String> body = {};

    if (profileInfo.address != userProfile.address) {
      if (profileInfo.address.city != userProfile.address.city)
        body['city'] = profileInfo.address.city;
      if (profileInfo.address.stAddress != userProfile.address.stAddress)
        body['stAddress'] = profileInfo.address.stAddress;
    }

    if (profileInfo.bio != userProfile.userStore?.bio) {
      body['bio'] = profileInfo.bio;
    }

    if (profileInfo.storeName != userProfile.userStore?.storeName) {
      body['store_name'] = profileInfo.storeName;
    }

    return body;
  }
}
