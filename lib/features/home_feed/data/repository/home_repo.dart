import 'dart:async';

import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/core/error/exception.dart';
import 'package:mobox/features/home_feed/data/data_source/local/local_home_data_souce.dart';
import 'package:mobox/features/home_feed/data/data_source/remote/remote_home_data_source.dart';
import 'package:rxdart/rxdart.dart';

class HomeRepo {
  final LocalHomeDataSource _localHomeDataSource;
  final RemoteHomeDataSource _remoteHomeDataSource;

  HomeRepo(
      {required LocalHomeDataSource localHomeDataSource,
      required RemoteHomeDataSource remoteHomeDataSource})
      : _localHomeDataSource = localHomeDataSource,
        _remoteHomeDataSource = remoteHomeDataSource;

  /// Return list of [newProductList] the user.
  ///
  /// Store the incoming data in cache [_localHomeDataSource] in case there no internet connection or
  /// something went wrong.
  ///
  /// Throws an [ConnectionExceptionWithData] if something go wrong while fetch the
  /// data.
  ///
  /// The Exception has list of cached data *[ConnectionExceptionWithData.data]* to display for the user.
  Stream<Product> getNewProductsStream() {
    var newProductsLocalStream = _localHomeDataSource.getNewProductStream();

    var newProductsRemoteStream = _remoteHomeDataSource.getNewProductStream();

    _localHomeDataSource.appendOfferList(newProductsLocalStream.toList());

    return Rx.concat([newProductsLocalStream, newProductsRemoteStream]);
  }

  /// Returns stream of [Product]s from local cache and remote if possible.
  ///
  /// Store the incoming data in cache [LocalHomeDataSource] in case there are
  //  no internet connection or something went wrong.
  //
  /// concat the two streams in one stream, local stream come first then
  /// the remote stream came behind it.
  ///
  /// ``  Rx.concat([local,remote])
  /// ``
  ///

  Stream<Product> getAdStream() {
    var adLocalStream = _localHomeDataSource.getAdStream();

    var adRemoteStream =
        _remoteHomeDataSource.getAdStream().asBroadcastStream();

    Future.microtask(
        () => _localHomeDataSource.appendAdList(adRemoteStream.handleError((_) {
              return; //ignore the error
            }).toList()));

    return Rx.concat([adLocalStream, adRemoteStream]);
  }

  ///  Returns stream of [Product]s from local cache.
  Stream<Product> getLocalAdStream() => _localHomeDataSource.getAdStream();

  /// Return list of [offerList] the user.
  ///
  /// Store the incoming data in cache [_localHomeDataSource] in case there no internet connection or
  /// something went wrong.
  ///
  /// Throws an [ConnectionExceptionWithData] if something go wrong while fetch the
  /// data.
  ///
  /// The Exception has list of cached data *[ConnectionExceptionWithData.data]* to display for the user.
  Stream<Product> getOffersStream() {
    var offersLocalStream = _localHomeDataSource.getOfferStream();

    var offersRemoteStream = _remoteHomeDataSource.getOfferStream();

    _localHomeDataSource.appendOfferList(offersLocalStream.toList());

    return Rx.concat([offersLocalStream, offersRemoteStream]);
  }
}
