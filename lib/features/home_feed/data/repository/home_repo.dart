import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/core/error/exception.dart';
import 'package:mobox/features/home_feed/data/data_source/local/local_home_data_souce.dart';
import 'package:mobox/features/home_feed/data/data_source/remote/remote_home_data_source.dart';

class HomeRepo {
  final LocalHomeDataSource localHomeDataSource;
  final RemoteHomeDataSource remoteHomeDataSource;

  HomeRepo(
      {required this.localHomeDataSource, required this.remoteHomeDataSource});

  /// Return list of [newProductList] the user.
  ///
  /// Store the incoming data in cache [localHomeDataSource] in case there no internet connection or
  /// something went wrong.
  ///
  /// Throws an [ConnectionExceptionWithData] if something go wrong while fetch the
  /// data.
  ///
  /// The Exception has list of cached data *[ConnectionExceptionWithData.data]* to display for the user.
  Future<List<Product>?> getNewProductsList() async {
    var newProductList = await remoteHomeDataSource.getNewProductList();
    if (newProductList != null) {
      localHomeDataSource.setNewProductList(newProductList);
      return newProductList;
    } else {
      // if the local cache is null, then return null and handle that in the ui
      // indicating that there is no data!
      // TODO : handle that case if there is no data in cache nor api return data like display image
      newProductList = localHomeDataSource.getNewProductList();
      throw ConnectionExceptionWithData(newProductList);
    }
  }
  /// Return list of [adList] the user.
  ///
  /// Store the incoming data in cache [localHomeDataSource] in case there no internet connection or
  /// something went wrong.
  ///
  /// Throws an [ConnectionExceptionWithData] if something go wrong while fetch the
  /// data.
  ///
  /// The Exception has list of cached data *[ConnectionExceptionWithData.data]* to display for the user.
  Future<List<Product>?> getAdList() async {
    var adList = await remoteHomeDataSource.getAdList();
    if (adList != null) {
      localHomeDataSource.setAdList(adList);
      return adList;
    } else {
      // if the local cache is null, then return null and handle that in the ui
      // indicating that there is no data!
      adList = localHomeDataSource.getAdList();
      throw ConnectionExceptionWithData(adList);
    }
  }

  /// Return list of [offerList] the user.
  ///
  /// Store the incoming data in cache [localHomeDataSource] in case there no internet connection or
  /// something went wrong.
  ///
  /// Throws an [ConnectionExceptionWithData] if something go wrong while fetch the
  /// data.
  ///
  /// The Exception has list of cached data *[ConnectionExceptionWithData.data]* to display for the user.
  Future<List<Product>?> getOffersList() async {
    var offerList = await remoteHomeDataSource.getOfferList();
    if (offerList != null) {
      localHomeDataSource.setOfferList(offerList);
      return offerList;
    } else {
      // if the local cache is null, then return null and handle that in the ui
      // indicating that there is no data!
      offerList = localHomeDataSource.getOfferList();
      throw ConnectionExceptionWithData(offerList);
    }
  }
}
