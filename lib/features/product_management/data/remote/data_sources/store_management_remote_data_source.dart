import 'dart:convert';
import 'dart:io';

import 'package:mobox/core/error/exception.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/core/utils/api_urls.dart';
import 'package:http/http.dart' as http;
import 'package:mobox/features/product_management/data/model/editable_product_info.dart';

abstract class ProductManagementRemoteDataSource {
  Future<Product> addNewProduct(EditableProductInfo newProduct);

  Future<Product> editExistingProduct(
      Product product, EditableProductInfo newProductInfo);

  Future<bool> deleteProduct(Product product);
}

class ProductManagementRemoteDataSourceImpl
    extends ProductManagementRemoteDataSource {
  final http.Client client;

  /// user token
  final String token;

  ProductManagementRemoteDataSourceImpl(
      {required this.client, required this.token});

  @override
  Future<Product> addNewProduct(EditableProductInfo newProduct) async {
    // TODO :: remove this lines in production
    var str = """ {
      "id": 7984561755,
      "title": "ti",
      "storeName": "storeName1",
      "storeId": "nidal",
      "imageUrl": "assets/images/productimg2.png",
      "price": 99.9,
      "sale": 1.1,
      "myRate": 1.0,
      "description": "do the same while you can dip in and out of a chapter to get just the morsel of information you need, why not pause for a minute and savor the experience of actually holding this book and going deeper? ",
      "rate": 2.5
    }""";
    return Product.fromMap(json.decode(str));
    // TODO:: to here !!
    Map<String, dynamic> body = {};
    body['title'] = newProduct.title;
    body['price'] = newProduct.price;
    body['description'] = newProduct.description;
    body['offer'] = newProduct.sale;

    return _uploadProductWithDataHeader(newProduct.imagePath, body, 'POST');
  }

  @override
  Future<Product> editExistingProduct(
      Product product, EditableProductInfo newProductInfo) async {
    // TODO :: remove this lines in production
    var str = """ {
      "id": ${product.id},
      "title": "ti",
      "storeName": "storeName1",
      "storeId": "nidal",
      "imageUrl": "assets/images/productimg2.png",
      "price": 99.9,
      "sale": 1.1,
      "myRate": 1.0,
      "description": "do the same while you can dip in and out of a chapter to get just the morsel of information you need, why not pause for a minute and savor the experience of actually holding this book and going deeper? ",
      "rate": 2.5
    }""";
    return Product.fromMap(json.decode(str));
    // TODO:: to here !!
    Map<String, dynamic> body =
        _getBodyMapFromProductInfo(product, newProductInfo);

    if (newProductInfo.imagePath != product.imageUrl) {
      var product = await _uploadProductWithDataHeader(
          newProductInfo.imagePath, body, 'PATCH');
      return product;
    }

    var res = await client.patch(
        Uri.parse(
          ApiUrl.BASE_URL + '/product?token=$token',
        ),
        body: json.encode(body));
    if (res.statusCode != 200)
      throw ConnectionException(
          'con not edit the product check internet connection!');
    var updatedProduct = jsonDecode(res.body)['product'];
    if (updatedProduct == 'null') throw BadReturnedData(updatedProduct);

    return Product.fromMap(updatedProduct);
  }

  Map<String, dynamic> _getBodyMapFromProductInfo(
      Product product, EditableProductInfo newProductInfo) {
    Map<String, dynamic> body = {};

    body['product_no'] = product.id;
    if (newProductInfo.title != product.title)
      body['title'] = newProductInfo.title;
    if (newProductInfo.price != product.price)
      body['price'] = newProductInfo.price;
    if (newProductInfo.sale != product.sale)
      body['offer'] = newProductInfo.sale!;

    if (newProductInfo.description != product.description)
      body['description'] = newProductInfo.description;

    return body;
  }

  @override
  Future<bool> deleteProduct(Product product) async {
    // TODO :: remove this lines in production
    return true;
    // TODO:: to here !!
    var res = await client.delete(
        Uri.parse(
          ApiUrl.BASE_URL + '/product?token=$token',
        ),
        body: json.encode({'product_no': product.id}));
    if (res.statusCode != 200 || jsonDecode(res.body)['success'] == 'false')
      return false;
    return true;
  }

  Future<Product> _uploadProductWithDataHeader(
      String imagePath, Map<String, dynamic> headers, String method) async {
    var file = File.fromUri(Uri.file('$imagePath'));
    var req = http.MultipartRequest(
        method, Uri.parse(ApiUrl.BASE_URL + '/product'))
      ..headers['token'] = '$token'
      ..headers
          .addAll(headers.map((key, value) => MapEntry(key, value.toString())))
      ..files.add(http.MultipartFile.fromBytes(
        'image',
        await file.readAsBytes(),
      ));
    var res = await req.send();

    if (res.statusCode != 200) {
      throw ConnectionException(
          'can not $method product check internet connection!');
    }
    var product =
        jsonDecode(await res.stream.transform(utf8.decoder).first)['product'];

    if (product == 'null') throw BadReturnedData(product);

    return Product.fromMap(product);
  }
}
