import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobox/core/error/exception.dart';

abstract class RemoteStoreDataSource {
  Future<bool> getFollowStateForStore({required String storeUserName});

  void setFollowStateForStore(
      {required String storeUserName, required bool followState});
}

class RemoteStoreDataSourceImpl extends RemoteStoreDataSource {
  final http.Client client;

  /// user token
  final String token;

  RemoteStoreDataSourceImpl({required this.client, required this.token});

  @override
  Future<bool> getFollowStateForStore({required String storeUserName}) async {
    // TODO : add our website

    // var res = await client.get(Uri.parse(
    //     'https://api.mobex.com/follow&storeUserName=$storeUserName&token=$token'));

    var res =
        await Future.value(http.Response('{"follow_state":"false"}', 200));
    if (res.statusCode == 200) {
      return jsonDecode(res.body)['follow_state'] as bool;
    } else {
      throw ConnectionException(
          'con not load the follow state, check internet connection');
    }
  }

  @override
  void setFollowStateForStore(
      {required String storeUserName, required bool followState}) async {
    // TODO : add our website
    // var res = await client.put(Uri.parse(
    //     'https://api.mobex.com/follow&storeUserName=$storeUserName&followState=$followState&token=$token'));
    // if (res.statusCode != 200) {
    //   throw ConnectionException(
    //       'con not set the follow state for a store, check internet connection');
    // }
  }
}
