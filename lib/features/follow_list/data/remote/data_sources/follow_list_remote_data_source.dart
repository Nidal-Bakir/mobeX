import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mobox/core/model/store_model.dart';
import 'package:mobox/core/utils/api_urls.dart';

abstract class FollowListRemoteDataSource {
  Stream<Store> getStoresTheUserFollow();
}

class FollowListRemoteDataSourceImpl extends FollowListRemoteDataSource {
  /// user token
  final String _token;
  final http.Client _client;

  late final String url;

  // for pagination
  String? nextPageUrl;

  FollowListRemoteDataSourceImpl(this._token, this._client) {
    url = ApiUrl.BASE_URL + "/user_follow?token=$_token";
    nextPageUrl = url;
  }
  @override
  Stream<Store> getStoresTheUserFollow() async* {
    // no next page just return empty stream
    if (nextPageUrl == null) {
      yield* Stream.empty();
      return;
    }
    // TODO : remove test codee
    var fileContent =
        await rootBundle.loadString('assets/for_tests_temp/store.json');
    var followList = (jsonDecode(fileContent)['stores'] as List)
        .map((e) => Store.fromMap(e));
    yield* Stream.fromIterable(followList);

    // TODO : end test code
    // http.Request request = http.Request("GET", Uri.parse(nextPageUrl!));
    // var res = await _client.send(request);
    // if (res.statusCode == 200) {
    //   yield* res.stream
    //       .transform(utf8.decoder)
    //       .transform(json.decoder)
    //       .map((event) {
    //         nextPageUrl = (event as Map)['next_page_link'];
    //         return (event)['stores'];
    //       })
    //       .expand((element) => element)
    //       .map((e) => Store.fromMap(e));
    // } else {
    //   yield* Stream.error(ConnectionException);
    // }
  }
}
