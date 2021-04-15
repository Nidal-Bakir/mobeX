import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobox/core/error/exception.dart';

abstract class RemoteCategories {
  Future<List<String>> getCategoriesListFromApi();
}

class RemoteCategoriesImpl extends RemoteCategories {
  /// user token
  final String token;
  final http.Client _client;

  RemoteCategoriesImpl({required http.Client client, required this.token})
      : _client = client;

  @override
  Future<List<String>> getCategoriesListFromApi() async {
    // TODO : add our website
    //TODO : use the token filed from super class

    // var res =
    //     await _client.get(Uri.parse('https://api.mobex.com/categories$token'));
    // if (res.statusCode == 200) {
    //   return jsonDecode(res.body)['categories'] as List<String>;
    // } else {
    //   throw ConnectionException('error while fetching categories list');
    // }
    String apiRes = """{"categories":["IT","phones","kitchen","furniture"]}""";
    var res = http.Response(apiRes, 200);
    if (res.statusCode == 200) {
      return jsonDecode(res.body)['categories'].cast<String>();
    } else {
      throw ConnectionException('error while fetching categories list');
    }
  }
}
