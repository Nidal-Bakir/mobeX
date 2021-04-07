import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:mobox/core/model/product_model.dart';

abstract class RemoteHomeDataSource {
  final String token;

  const RemoteHomeDataSource({required this.token});

  Future<List<Product>?> getAdList();

  Future<List<Product>?> getOfferList();

  Future<List<Product>?> getNewProductList();
}

class RemoteHomeDataSourceImpl extends RemoteHomeDataSource {
  final Client client;

  RemoteHomeDataSourceImpl({required this.client, required String token})
      : super(token: token);

  @override
  Future<List<Product>?> getAdList() async {
    return _getProductDataFromApi('OfferList');
  }

  @override
  Future<List<Product>?> getNewProductList() async {
    return _getProductDataFromApi('OfferList');
  }

  @override
  Future<List<Product>?> getOfferList() async {
    return _getProductDataFromApi('OfferList');
  }

  Future<List<Product>?> _getProductDataFromApi(String endPoint) async {
    // TODO : add our website
    //TODO : use the token filed from super class

    var res = await Future.value(Response(
        await rootBundle.loadString('assets/for_tests_temp/products.json'),
        200));
    if (res.statusCode != 200) {
      return null;
    }
    return (json.decode(res.body)['products'] as List<dynamic>)
        .map((e) => Product.fromMap(e))
        .toList();
  }
}
