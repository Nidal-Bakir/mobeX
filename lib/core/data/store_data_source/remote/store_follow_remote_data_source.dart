import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobox/core/error/exception.dart';
import 'package:mobox/core/model/store_model.dart';

abstract class RemoteStoreDataSource {
  Future<bool> getFollowStateForStore({required String storeUserName});

  void setFollowStateForStore(
      {required String storeUserName, required bool followState});

  Future<Store> getStoreInfoFromStoreUserName({required String storeUserName});
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

  @override
  Future<Store> getStoreInfoFromStoreUserName(
      {required String storeUserName}) async {
    // TODO : add our website

    var res = await Future.value(http.Response(
        '{"user_name": "12","store_name": "store2","profile_image": "assets/images/productimg2.png","bio": "the new bio is herre"}',
        200));
    if (res.statusCode == 200) {
      return Store.fromMap(json.decode(res.body));
    }
    throw ConnectionException(
        'cannot get store form storeUserName $storeUserName');
  }
}
