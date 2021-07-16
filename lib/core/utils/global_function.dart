import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

bool notificationListener(
    {required ScrollNotification notification,
    required void Function() onNotify}) {
  if (notification.metrics.pixels >=
      notification.metrics.maxScrollExtent * 0.9) {
    onNotify();
  }
  return true;
}

void showSnack(BuildContext context, String text) {
  ScaffoldMessenger.maybeOf(context)
    ?..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text(
          '$text',
        ),
      ),
    );
}

Future<bool> uploadImageWithDataHeader({
  required String token,
  required String endPoint,
  required String imagePath,
  required Map<String, dynamic> headers,
  required String method,
}) async {
  var file = File.fromUri(Uri.file('$imagePath'));

  var req = http.MultipartRequest(method, Uri.parse(endPoint))
    ..headers['token'] = '$token'
    ..headers
        .addAll(headers.map((key, value) => MapEntry(key, value.toString())))
    ..files.add(http.MultipartFile.fromBytes(
      'image',
      await file.readAsBytes(),
    ));

  var res = await req.send();
  if (res.statusCode == 200)
    return jsonDecode(
                await res.stream.transform(utf8.decoder).first)['success'] ==
            'true'
        ? true
        : false;

  return false;
}
