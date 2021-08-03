import 'dart:convert';

import 'package:http/http.dart';
import 'package:mobox/ForTestClass.dart';
import 'package:mobox/core/model/user_profiel.dart';
import 'package:mobox/core/error/exception.dart';

abstract class RemoteAuth {
  /// login the user using [userName] and [password] and get his profile form the server
  ///
  /// Returns [UserProfile] object hold the user info.
  ///
  /// Throws [AuthenticationException] if the [userName] or [password] is invalid.
  ///
  /// Throws [ConnectionException] if the user doesn't have a proper internet
  /// connection or he is not connected to internet.
  Future<UserProfile> login(
      {required String userName, required String password});

  /// get updated user profile form the server
  ///
  /// [token] user toke which will be used to identify the user
  ///
  /// Returns [UserProfile] object hold the undated info about the user
  ///
  /// Throws [AuthenticationException] if the token is invalid.
  ///
  /// Throws [ConnectionException] if the user doesn't have a proper internet
  /// connection or he is not connected to internet.
  Future<UserProfile> getUpdatedUserProfile({required String token});
}

class RemoteAuthImpl extends RemoteAuth {
  // TODO :: remove this member it is for testing

  final Client client;

  RemoteAuthImpl({required this.client});

  @override
  Future<UserProfile> login(
      {required String userName, required String password}) async {
    return await _getUserProfileFromApi(
        'login&userName=$userName&password=$password');
  }

  Future<UserProfile> _getUserProfileFromApi(String endPoint) async {
    // TODO : add our website
    // var res =
    // await _client.get(Uri.https(ApiUrl.BASE_URL\$endPoint));
    var res;

    if (ForTestClass.isAStore) {
      res = await Future.value(Response(
          '{"token":"123abc","user_name":"nidal","balance":12000,"profile_image":"assets/images/productimg2.png","phone":"1234567890","city":"home","address":"alware 22st","first_name":"nidal","last_name":"bakir","account_status":"active","user_store":null}',
          200));
        // TODO :: remove this code it is for testing

    } else {
      // TODO :: remove this code it is for testing

      res = await Future.value(Response(
          '{"token":"123abc","user_name":"nidal","balance":12000,"profile_image":"assets/images/productimg2.png","phone":"1234567890","city":"home","address":"alware 22st","first_name":"nidal","last_name":"bakir","account_status":"active","user_store":{"store_name":"nidal store","bio":"my bio","available_assets":12000,"frozen_assets":2000,"over_all_profit":15000}}',
          200));
    }

    if (res.statusCode == 200) {
      var jsonMap = json.decode(res.body);
      if (jsonMap == 'null') {
        throw AuthenticationException('wrong username or password try again!');
      } else if (jsonMap == 'invalid token') {
        throw AuthenticationException('invalid token need to login again');
      } else {
        return UserProfile.fromMap(jsonMap);
      }
    } else {
      throw ConnectionException('check your internet connection');
    }
  }

  @override
  Future<UserProfile> getUpdatedUserProfile({required String token}) async {
    return await _getUserProfileFromApi("userProfile&token=$token");
  }
}
