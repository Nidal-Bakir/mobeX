import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mobox/core/error/exception.dart';
import 'package:mobox/core/model/store_model.dart';

abstract class RemoteSearchDataSource {
  Stream<Store> searchStoresByName(
      {required String storeName, required int paginationCount});
}

class RemoteSearchDataSourceImpl extends RemoteSearchDataSource {
  final http.Client client;

  /// user token
  final String token;

  RemoteSearchDataSourceImpl({required this.client, required this.token});

  @override
  Stream<Store> searchStoresByName({
    required String storeName,
    required int paginationCount,
  }) async* {
    // TODO : add our website
    //TODO : use the token filed from  class

    // var req = http.Request(
    //     'get', Uri.parse('https://api.mobex.com/ad$token$storeName&&paginationCount$paginationCount'));
    // var res = await client.send(req);
    //
    // if (res.statusCode == 200) {
    //  yield* res.stream
    //       .transform(utf8.decoder)
    //       .transform(json.decoder)
    //       .expand((element) => [...element as List])
    //       .map((event) => Store.formMap(event));
    //
    // }else {
    //  yield throw ConnectionException('error while fetching $storeName data');
    // }
    var res = await Future.value(http.Response(
        await rootBundle.loadString('assets/for_tests_temp/store.json'), 200));
    if (res.statusCode == 200) {
      yield* Stream.fromIterable(
          (json.decode(res.body)['stores'] as List<dynamic>)
              .map((e) {
                e['user_name'] = Random().nextInt(999999999).toString();

                return Store.formMap(e);
              })
              .where((element) => element.storeName == storeName)
              .toList());
    } else {
      yield throw ConnectionException(
          'error while searching for $storeName products');
    }
  }
}
