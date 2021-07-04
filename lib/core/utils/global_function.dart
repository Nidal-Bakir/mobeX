import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
