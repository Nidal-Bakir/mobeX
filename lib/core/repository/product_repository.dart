import 'dart:async';

import 'package:mobox/core/data/product_data_source/local/local_product_source.dart';
import 'package:mobox/core/data/product_data_source/remote/remote_product_source.dart';
import 'package:mobox/core/error/exception.dart';
import 'package:mobox/core/model/product_model.dart';

class ProductRepository {
  final LocalProductDataSource _localProductDataSource;
  final RemoteProductDataSource _remoteProductDataSource;

  ProductRepository(
      {required LocalProductDataSource localProductDataSource,
      required RemoteProductDataSource remoteProductDataSource})
      : _localProductDataSource = localProductDataSource,
        _remoteProductDataSource = remoteProductDataSource;

  /// Returns stream of [Product]s from local cache and remote if possible.
  ///
  /// Store the incoming data in cache [LocalProductDataSource] in case there are
  //  no internet connection or something went wrong.
  //
  /// emit the local streams first, and then the remote stream.
  ///

  Stream<Product> getProductsStreamFromEndPoint(String endPoint) async* {
    // use this number to tall the api to send the next products list relative
    // to this number
    var numberOfProductsForPagination =
        _localProductDataSource.getNumberOfCachedProductsForEndPoint(endPoint);

    yield* _localProductDataSource.getProductsStreamFromLocalEndPoint(endPoint);

    var remoteStream = _remoteProductDataSource
        .getProductsStreamFromEndPoint(
            endPoint: endPoint, paginationCount: numberOfProductsForPagination)
        .asBroadcastStream();

    _localProductDataSource.appendCache(
        remoteStream.handleError((_) {
          return; //ignore the error
        }).toList(),
        endPoint);

    yield* remoteStream;
  }

  Stream<Product> getProductsStreamFromAPIForInfiniteScrolling(
      String endPoint) async* {
    // use this number to tall the api to send the next products list relative
    // to this number
    var numberOfProductsForPagination =
        _localProductDataSource.getNumberOfCachedProductsForEndPoint(endPoint);

    var remoteStream = _remoteProductDataSource
        .getProductsStreamFromEndPoint(
          endPoint: endPoint,
          paginationCount: numberOfProductsForPagination,
        )
        .asBroadcastStream();

    _localProductDataSource.appendCache(
        remoteStream.handleError((_) {
          return; //ignore the error
        }).toList(),
        endPoint);

    yield* remoteStream;
  }

  ///  Returns stream of [Product]s from local cache.
  Stream<Product> getProductsStreamFromLocalCache(String endPoint) =>
      _localProductDataSource.getProductsStreamFromLocalEndPoint(endPoint);

  /// Sends the user [newRate] to the API
  /// the server Response with the updated rate for a product.
  ///
  /// [oldRate] used to determine which operation to invoke post, delete or patch.
  ///
  /// Update the corresponding [product] in the local cache.
  ///
  /// Returns Map<String, double?> of newProductRateFromAPI and userRate.
  ///
  /// Throw [ConnectionException] if the server did not response or there are no internet connection
  Future<Map<String, double?>> sendUserRateForProduct(double? oldRate,
      double? newRate, Product product, String endPoint) async {
    try {
      double newProductRateFromAPI = await _remoteProductDataSource
          .upDateProductRate(product.id, product.storeId, oldRate, newRate);

      _localProductDataSource.upDateProduct(endPoint,
          product.copyWith(rate: newProductRateFromAPI, myRate: newRate));
      return {
        'newProductRateFromAPI': newProductRateFromAPI,
        'newRate': newRate,
      };
    } on ConnectionException catch (e) {
      rethrow;
    }
  }

  Stream<Product> searchProductsByTitle({
    required String title,
    double? priceLessThenOrEqual,
    required int paginationCount,
  }) =>
      _remoteProductDataSource.searchProductsByTitle(
          title: title,
          priceLessThenOrEqual: priceLessThenOrEqual,
          paginationCount: paginationCount);

  /// Add product in local cache.
  ///
  /// [endPoint] where to add the  product in cache.
  ///
  /// [product] is the product will add.
  void addProduct(String endPoint, Product product) {
    _localProductDataSource.addProduct(endPoint, product);
  }

  /// Update product in local cache.
  ///
  /// [endPoint] where the product stored in cache.
  ///
  /// [product] is the updated product.
  void updateProduct(String endPoint, Product product) {
    _localProductDataSource.upDateProduct(endPoint, product);
  }
  /// Delete product from local cache.
  ///
  /// [endPoint] where the product stored in cache.
  ///
  /// [product] is the product you need to delete.
  void deleteProduct(String endPoint, Product product) {
    _localProductDataSource.deleteProduct(endPoint, product);
  }
}
