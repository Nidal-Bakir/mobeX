import 'dart:convert';

import 'package:http/http.dart';
import 'package:mobox/core/auth/data/model/user_profiel.dart';
import 'package:mobox/core/error/exception.dart';

abstract class RemoteAuth {
  Future<UserProfile> login(
      {required String userName, required String password});
}

class RemoteAuthImpl extends RemoteAuth {
  final Client client;

  RemoteAuthImpl({required this.client});

  @override
  Future<UserProfile> login(
      {required String userName, required String password}) async {
    return await _getUserIdFromApi(userName, password);
  }

  Future<UserProfile> _getUserIdFromApi(
      String userName, String password) async {
    // TODO : add our website
    // var res =
    // await _client.get(Uri.https(ApiUrl.BASE_URL, '$userName,$password'));
    var res = await Future.value(Response(
        '{"token":"123abc","user_name":"nidal","balance":"12000","profile_image":"assets/images/productimg2.png","phone":"1234567890","city":"home","address":"alware 22st","first_name":"nidal","last_name":"bakir","account_status":"active"}',
        200));

    if (res.statusCode == 200) {
      var jsonMap = json.decode(res.body);
      if (jsonMap == 'null') {
        throw AuthenticationException('wrong username or password try again!');
      } else {
        return UserProfile.fromMap(jsonMap);
      }
    } else {
      throw CannotLoginException('check your internet connection');
    }
  }
}
