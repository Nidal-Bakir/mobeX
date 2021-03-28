import 'dart:convert';

import 'package:http/http.dart';
import 'package:mobox/utils/exception.dart';

abstract class RemoteAuth {
  Future<String> login({required String userName, required String password});
}

class RemoteAuthImpl extends RemoteAuth {
  final Client client;

  RemoteAuthImpl({required this.client});

  @override
  Future<String> login(
      {required String userName, required String password}) async {
    return await _getUserIdFromApi(userName, password);
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
}
