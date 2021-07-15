import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mobox/core/error/exception.dart';
import 'package:mobox/core/model/order_item.dart';
import 'package:mobox/core/utils/api_urls.dart';
import 'package:mobox/features/purchase_orders/data/model/purchase_orders.dart';
import 'package:http/http.dart' as http;

abstract class PurchaseOrdersRemoteDataSource {
  Stream<PurchaseOrder> getPurchaseOrders();

  Future<bool> updatePurchaseOrderState(
      PurchaseOrder purchaseOrder, OrderItemState newState);
}

class PurchaseOrdersRemoteDataSourceImpl
    extends PurchaseOrdersRemoteDataSource {
  /// user token
  final String _token;
  final http.Client _client;

  late final String url;

  // for pagination
  String? nextPageUrl;

  PurchaseOrdersRemoteDataSourceImpl(this._token, this._client) {
    url = ApiUrl.BASE_URL + "/purchase_orders?token=$_token";
    nextPageUrl = url;
  }

  @override
  Stream<PurchaseOrder> getPurchaseOrders() async* {
    // no next page just return empty stream
    if (nextPageUrl == null) {
      yield* Stream.empty();
      return;
    }
    // TODO : remove test codee
    var fileContent = await rootBundle
        .loadString('assets/for_tests_temp/purchase_orders.json');
    var purchaseOrders = (jsonDecode(fileContent)['data'] as List)
        .map((e) => PurchaseOrder.fromMap(e));
    yield* Stream.fromIterable(purchaseOrders);


    // TODO : end test code
    // http.Request request = http.Request("GET", Uri.parse(nextPageUrl!));
    // var res = await _client.send(request);
    // if (res.statusCode == 200) {
    //   yield* res.stream
    //       .transform(utf8.decoder)
    //       .transform(json.decoder)
    //       .map((event) {
    //         nextPageUrl = (event as Map)['next_page_link'];
    //         return (event)['data'];
    //       })
    //       .expand((element) => element)
    //       .map((purchaseOrders) => PurchaseOrder.fromMap(purchaseOrders));
    // } else {
    //   yield* Stream.error(ConnectionException);
    // }
  }

  @override
  Future<bool> updatePurchaseOrderState(
      PurchaseOrder purchaseOrder, OrderItemState newState) async {
    // TODO : remove this return
    return true;
    var res = await _client.patch(
      Uri.parse(url +
          "&order_no=${purchaseOrder.orderId}&item_no=${purchaseOrder.id}"),
      body: {
        "item_state": OrderItemState.Delivered.toString().split('.')[1],
      },
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body)["success"] as bool;
    }
    return false;
  }
}
