import 'dart:async';

import 'package:mobox/core/data/product_data_source/local/local_product_source.dart';
import 'package:mobox/core/data/product_data_source/remote/remote_product_source.dart';
import 'package:mobox/core/model/product_model.dart';

import 'package:rxdart/rxdart.dart';

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
  /// concat the two streams in one stream, local stream come first then
  /// the remote stream came behind it.
  ///
  /// ``  Rx.concat([local,remote])
  /// ``
  ///

  Stream<Product> getProductsStreamFromEndPoint(String endPoint) {
    var localStream =
        _localProductDataSource.getProductsStreamFromLocalEndPoint(endPoint);

    var remoteStream = _remoteProductDataSource
        .getProductsStreamFromEndPoint(endPoint)
        .asBroadcastStream();

    Future.microtask(() => _localProductDataSource.appendCache(
        remoteStream.handleError((_) {
          return; //ignore the error
        }).toList(),
        endPoint));

    return Rx.concat([localStream, remoteStream]);

  }

  ///  Returns stream of [Product]s from local cache.
  Stream<Product> getProductsStreamFromLocalCache(String endPoint) =>
      _localProductDataSource.getProductsStreamFromLocalEndPoint(endPoint);
}
