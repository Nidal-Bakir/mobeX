import 'dart:convert';

import 'package:mobox/core/error/exception.dart';
import 'package:mobox/core/utils/api_urls.dart';
import 'package:mobox/features/cart/data/models/check_out_order.dart';
import 'package:mobox/features/order/data/models/order.dart';
import 'package:http/http.dart' as http;

abstract class CartRemoteDataSource {
  Future<Order> checkOut(CheckOutOrder checkOutOrder);
}

class CartRemoteDataSourceImpl extends CartRemoteDataSource {
  /// user token
  final String _token;
  final http.Client _client;

  CartRemoteDataSourceImpl(this._token, this._client);

  @override
  Future<Order> checkOut(CheckOutOrder checkOutOrder) async {
    return Order();
    var res = await _client.post(
        Uri.parse(ApiUrl.BASE_URL + '/checkout&token=$_token'),
        body: jsonEncode(
          checkOutOrder.toMap(),
        ));
    if (res.statusCode == 200) {
      var resMap = jsonDecode(res.body);
      if (resMap['success'] == 'true') {
        return Order.fromMap(resMap['order']);
      } else {
        throw InsufficientBalance(resMap['reason']);
      }
    }

    throw ConnectionException(
        'can not place your order check your internet connection!');
  }
}
