import 'dart:convert';

import 'package:mobox/utils/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

/// base class
abstract class Auth {
  Future<String?> getUserToken();

  Future<String> login({required String userName, required String password});
}

class HttpAuth extends Auth {
  final Client _client;

  HttpAuth(Client httpClient) : _client = httpClient;

  /// get user id if present or return null
  @override
  Future<String?> getUserToken() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString('id');
  }

  @override
  Future<String> login(
      {required String userName, required String password}) async {
    var token = await _getUserIdFromApi(userName, password);
    _storeTheToken(token);
    return token;
  }

  Future<String> _getUserIdFromApi(String userName, String password) async {
    // TODO : add our website
    // var res =
    // await _client.get(Uri.https(ApiUrl.BASE_URL, '$userName,$password'));
    var res = await Future.value(Response('{"token":"123abc"}', 200));

    if (res.statusCode == 200) {
      var token = json.decode(res.body)['token'] as String;
      if (token == 'null') {
        throw AuthenticationException('wrong username or password try again!');
      } else {
        return token;
      }
    } else {
      throw CannotLoginException('check your internet connection');
    }
  }

  void _storeTheToken(String token) {
    SharedPreferences.getInstance().then((pref) => pref.setString('id', token));
  }
}
