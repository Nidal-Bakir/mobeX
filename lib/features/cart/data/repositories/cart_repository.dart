import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/features/cart/data/local/data_sources/cart_local_data_source.dart';
import 'package:mobox/features/cart/data/models/check_out_order.dart';
import 'package:mobox/features/cart/data/remote/data_sources/cart_remote_source.dart';
import 'package:mobox/features/order/data/models/order.dart';

class CartRepository {
  CartRemoteDataSource _remoteDataSource;
  CartLocalDataSource _localDataSource;

  CartRepository(
      {required CartRemoteDataSource cartRemoteDataSource,
      required CartLocalDataSource cartLocalDataSource})
      : this._remoteDataSource = cartRemoteDataSource,
        this._localDataSource = cartLocalDataSource;

  void addProduct(Product product) => _localDataSource.addProduct(product);

  void deleteOrder() => _localDataSource.deleteOrder();

  void editQuantity(Product product, int newQuantity) =>
      _localDataSource.editQuantity(product, newQuantity);

  void deleteProduct(Product product) =>
      _localDataSource.deleteProduct(product);

  CheckOutOrder getCheckOutOrder() => _localDataSource.getCheckOutOrder();

  Future<Order> checkOut() async {
    var order =
        await _remoteDataSource.checkOut(_localDataSource.getCheckOutOrder());
    _localDataSource.deleteOrder();
    return order;
  }
}
