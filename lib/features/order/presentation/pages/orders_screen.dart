import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/error/exception.dart';
import 'package:mobox/core/utils/global_function.dart';
import 'package:mobox/core/widget/no_data.dart';
import 'package:mobox/core/widget/retry_button.dart';

import 'package:mobox/features/order/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:mobox/features/order/presentation/widgets/order_view.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    context.read<OrderBloc>().add(OrderNextPageLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your order'),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoadSuccess) {
            return NotificationListener<ScrollNotification>(
              onNotification: (notification) => notificationListener(
                notification: notification,
                onNotify: () =>
                    context.read<OrderBloc>().add(OrderNextPageLoaded()),
              ),
              child: ListView.builder(
                itemBuilder: (context, index) =>
                    OrderView(order: state.orders[index]),
                itemCount: state.orders.length,
              ),
            );
          } else if (state is OrderLoadMoreDataInProgress) {
            return ListView.builder(
              itemBuilder: (context, index) {
                if (index == state.orders.length + 1) {
                  return LinearProgressIndicator();
                }
                return OrderView(order: state.orders[index]);
              },
              itemCount: state.orders.length + 1,
            );
          } else if (state is OrderLoadFailure) {
            return ListView.builder(
              itemBuilder: (context, index) {
                if (state.orders.isEmpty||index == state.orders.length + 1) {
                  return Center(
                      child: RetryTextButton(
                    onClickCallback: () =>
                        context.read<OrderBloc>().add(OrderNextPageLoaded()),
                  ));
                }
                return OrderView(order: state.orders[index]);
              },
              itemCount: state.orders.length + 1,
            );
          } else if (state is OrderNothingPlaced) {
            return Center(
              child: NoData(
                title: 'We can not find any placed orders',
                vertical: true,
              ),
            );
          } else if (state is OrderInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          throw UnHandledStateException(state);
        },
      ),
    );
  }
}
