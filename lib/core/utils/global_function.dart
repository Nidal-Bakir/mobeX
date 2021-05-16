import 'package:flutter/widgets.dart';

bool notificationListener({required ScrollNotification notification,
   required void Function() onNotify}) {
  if (notification.metrics.pixels >=
      notification.metrics.maxScrollExtent * 0.9) {
    onNotify();
  }
  return true;
}
