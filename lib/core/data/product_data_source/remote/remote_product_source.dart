import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:mobox/core/error/exception.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:mobox/core/utils/api_urls.dart';

abstract class RemoteProductDataSource {
  const RemoteProductDataSource();

  /// Returns Stream of [Product]s from api
  ///
  /// Throws [ConnectionException] in the stream, if there is no internet or the
  /// server returns statusCode other than *(200 OK)*
  Stream<Product> getProductsStreamFromEndPoint(
      {required String endPoint, required int paginationCount});

  /// send to the server the user rate for a product
  ///
  /// if [newRate] is null that's mean the user Wants to delete his rate .
  ///
  /// if [oldRate] is null that's mean the user wants to rate this product.
  ///
  /// other than that the user update his rate on this product with [newRate].
  ///
  /// Returns product rate from the server.
  Future<double> upDateProductRate(
      int id, String storeId, double? oldRate, double? newRate);

  Stream<Product> searchProductsByTitle({
    required String title,
    double? priceLessThenOrEqual,
    required int paginationCount,
  });
}

class RemoteProductDataSourceImpl extends RemoteProductDataSource {
  final http.Client client;

  /// user token
  final String token;

  RemoteProductDataSourceImpl({required this.client, required this.token});

  @override
  Future<double> upDateProductRate(
      int id, String storeId, double? oldRate, double? newRate) async {
    http.Response res;
    // TODO : add our website
    //TODO : use the token filed from super class
    return (Random().nextDouble() * 10) % 6; // TODO REMOVE THIS LINE
    if (newRate == null) {
      res = await client.delete(
          Uri.parse(
            'https://api.mobex.com/$id$storeId$token',
          ),
          body: {},
          headers: {});
    } else if (oldRate == null) {
      res = await client.post(
          Uri.parse(
            'https://api.mobex.com/$id$storeId$token',
          ),
          body: {},
          headers: {});
    } else {
      res = await client.patch(
          Uri.parse(
            'https://api.mobex.com/$id$storeId$token',
          ),
          body: {},
          headers: {});
    }

    if (res.statusCode != 200 || res.body.isEmpty) {
      throw ConnectionException(
          "can't update the rate bad statusCode ${res.statusCode} or the server return empty Response");
    }

  }

  @override
  Stream<Product> getProductsStreamFromEndPoint({
    required String endPoint,
    required int paginationCount,
  }) async* {
    // TODO : add our website
    //TODO : use the token filed from super class
    // TODO : use paginationCount in the url

    // var req = http.Request(
    //     'get', Uri.parse('${ApiUrl.BASE_URL}/$endPoint?&token=$token&paginationCount=$paginationCount'));
    // var res = await client.send(req);
    //
    // if (res.statusCode == 200) {
    //  yield* res.stream
    //       .transform(utf8.decoder)
    //       .transform(json.decoder)
    //       .map((event) => (event as Map)['data'])
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
        (json.decode(res.body)['data'] as List<dynamic>).map((e) {

          e['id'] = Random().nextInt(999999999);
          e['product_name'] = endPoint;
          e['store_name'] = (++index).toString();
          return Product.fromMap(e);
        }).toList(),
      );
    } else {
      yield throw ConnectionException('error while fetching $endPoint data');
    }
  }

  @override
  Stream<Product> searchProductsByTitle({
    required String title,
    double? priceLessThenOrEqual,
    required int paginationCount,
  }) async* {
    // TODO : add our website
    //TODO : use the token filed from  class

    // var req = await http.Request(
    //     'get',
    //     Uri.parse(
    //         '${ApiUrl.BASE_URL}/search?&token=$token&title=$title&paginationCount=$paginationCount&priceLessThenOrEqual=$priceLessThenOrEqual'));
    // var res = await client.send(req);
    //
    // if (res.statusCode == 200) {
    //  yield* res.stream
    //       .transform(utf8.decoder)
    //       .transform(json.decoder)
    //        .map((event) => (event as Map)['data'])
    //       .expand((element) => [...element as List])
    //       .map((event) => Product.fromMap(event));
    //
    // }else {
    //  yield throw ConnectionException('error while searching for $title products');
    // }
    int index = 0;
    var res = await Future.value(http.Response(
        await rootBundle.loadString('assets/for_tests_temp/products.json'),
        200));
    if (res.statusCode == 200) {
      yield* Stream.fromIterable(
          (json.decode(res.body)['data'] as List<dynamic>)
              .map((e) {
                e['id'] = Random().nextInt(999999999);
                e['store_name'] = (++index).toString();

                return Product.fromMap(e);
              })
              .where((element) => element.title == title)
              .toList());
    } else {
      yield throw ConnectionException(
          'error while searching for $title products');
    }
  }
}
