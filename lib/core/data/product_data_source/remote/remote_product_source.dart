import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:mobox/core/error/exception.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteProductDataSource {
  const RemoteProductDataSource();

  /// Returns Stream of [Product]s from api
  ///
  /// Throws [ConnectionException] in the stream, if there is no internet or the
  /// server returns statusCode other than *(200 OK)*
  Stream<Product> getProductsStreamFromEndPoint(
      {required String endPoint, required int paginationCount});
}

class RemoteProductDataSourceImpl extends RemoteProductDataSource {
  final http.Client client;

  /// user token
  final String token;

  RemoteProductDataSourceImpl({required this.client, required this.token});

  @override
  Stream<Product> getProductsStreamFromEndPoint({
    required String endPoint,
    required int paginationCount,
  }) async* {
    // TODO : add our website
    //TODO : use the token filed from super class
    // TODO : use paginationCount in the url

    // var req = http.Request(
    //     'get', Uri.parse('https://api.mobex.com/ad$token$paginationCount'));
    // var res = await client.send(req);
    //
    // if (res.statusCode == 200) {
    //  yield* res.stream
    //       .transform(utf8.decoder)
    //       .transform(json.decoder)
    //       .expand((element) => [...element as List])
    //       .map((event) => Product.fromMap(event));
    //
    // }else {
    //  yield throw ConnectionException('error while fetching $endPoint data');
    // }
    int index = 0;
    var res = await Future.value(http.Response(
        await rootBundle.loadString('assets/for_tests_temp/products.json'),
        200));
    if (res.statusCode == 200) {
      yield* Stream.fromIterable(
        (json.decode(res.body)['products'] as List<dynamic>).map((e) {
          e['id']=Random().nextInt(999999999);
          e['title'] = endPoint;
          e['storeName'] = (++index).toString();
          return Product.fromMap(e);
        }).toList(),
      );
    } else {
      yield throw ConnectionException('error while fetching $endPoint data');
    }
  }
}
