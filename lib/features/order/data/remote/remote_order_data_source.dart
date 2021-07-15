import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mobox/core/error/exception.dart';
import 'package:mobox/core/utils/api_urls.dart';
import 'package:mobox/features/order/data/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:mobox/core/model/order_item.dart';

abstract class RemoteOrderDataSource {
  Stream<Order> getOrdersStream();

  Future<bool> markOderItemAsDelivered(int orderId, int itemId);
}

class RemoteOrderDataSourceImpl extends RemoteOrderDataSource {
  /// user token
  final String _token;
  final http.Client _client;
  late final String url;

  String? nextPageUrl;

  RemoteOrderDataSourceImpl(this._token, this._client) {
    url = ApiUrl.BASE_URL + "/orders?token=$_token";
    nextPageUrl = url;
  }

  @override
  Stream<Order> getOrdersStream() async* {
    // no next page just return empty stream
    if (nextPageUrl == null) {
      yield* Stream.empty();
      return;
    }

    // TODO : remove test codee
    var fileContent =
        await rootBundle.loadString('assets/for_tests_temp/orders.json');
    var order =
        (jsonDecode(fileContent)['data'] as List).map((e) => Order.fromMap(e));
    yield* Stream.fromIterable(order);
    return;
    // TODO : end test code
    http.Request request = http.Request("GET", Uri.parse(nextPageUrl!));
    var res = await _client.send(request);
    if (res.statusCode == 200) {
      yield* res.stream
          .transform(utf8.decoder)
          .transform(json.decoder)
          .map((event) {
            nextPageUrl = (event as Map)['next_page_link'];
            return (event)['data'];
          })
          .expand((element) => element)
          .map((order) => Order.fromMap(order));
    } else {
      yield* Stream.error(ConnectionException);
    }
  }

  @override
  Future<bool> markOderItemAsDelivered(int orderId, int itemId) async {
    // TODO : remove this return
    return true;
    var res = await _client.patch(
      Uri.parse(url + "&order_no=$orderId&item_no=$itemId"),
      body: {
        "item_state": OrderItemState.Delivered.toString(),
      },
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body)["success"] as bool;
    }
    return false;
  }
}
