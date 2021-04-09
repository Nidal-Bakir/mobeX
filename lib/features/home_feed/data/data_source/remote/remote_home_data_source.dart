import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mobox/core/error/exception.dart';
import 'package:mobox/core/model/product_model.dart';

abstract class RemoteHomeDataSource {
  /// user token
  final String token;

  const RemoteHomeDataSource({required this.token});

  /// Returns Stream of [Product]s from api
  ///
  /// Throws [ConnectionException] in the stream, if there is no internet or the
  /// server returns statusCode other than *(200 OK)*
  Stream<Product> getAdStream();

  /// Returns Stream of [Product]s from api
  ///
  /// Throws [ConnectionException] in the stream, if there is no internet or the
  /// server return statusCode other than *(200 OK)*
  Stream<Product> getOfferStream();

  /// Returns Stream of [Product]s from api
  ///
  /// Throws [ConnectionException] in the stream, if there is no internet or the
  /// server returns statusCode other than *(200 OK)*
  Stream<Product> getNewProductStream();
}

class RemoteHomeDataSourceImpl extends RemoteHomeDataSource {
  final http.Client client;

  RemoteHomeDataSourceImpl({required this.client, required String token})
      : super(token: token);

  @override
  Stream<Product> getAdStream() {
    return _getProductDataFromApi('ad');
  }

  @override
  Stream<Product> getNewProductStream() {
    return _getProductDataFromApi('newProduct');
  }

  @override
  Stream<Product> getOfferStream() {
    return _getProductDataFromApi('OfferList');
  }

  Stream<Product> _getProductDataFromApi(String endPoint) async* {
    // TODO : add our website
    //TODO : use the token filed from super class

    // var req = http.Request(
    //     'get', Uri.parse('https://api.mobex.com/ad$token'));
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

    var res = await Future.value(http.Response(
        await rootBundle.loadString('assets/for_tests_temp/products.json'),
        200));
    if (res.statusCode == 200) {
      yield* Stream.fromIterable(
        (json.decode(res.body)['products'] as List<dynamic>)
            .map((e) => Product.fromMap(e))
            .toList(),
      );
    } else {
      yield throw ConnectionException('error while fetching $endPoint data');
    }
  }
}
