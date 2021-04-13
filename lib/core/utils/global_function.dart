import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/bloc/product_bloc/product_bloc.dart';

bool notificationListener(
    ScrollNotification notification, BuildContext context) {
  if (notification.metrics.pixels >=
      notification.metrics.maxScrollExtent * 0.9) {
    context.read<ProductBloc>().add(ProductMoreDataLoaded());
  }
  return true;
}
