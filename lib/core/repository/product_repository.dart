import 'dart:async';

import 'package:mobox/core/data/product_data_source/local/local_product_source.dart';
import 'package:mobox/core/data/product_data_source/remote/remote_product_source.dart';
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
      String endPoint) {
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

    return remoteStream;
  }

  ///  Returns stream of [Product]s from local cache.
  Stream<Product> getProductsStreamFromLocalCache(String endPoint) =>
      _localProductDataSource.getProductsStreamFromLocalEndPoint(endPoint);
}
