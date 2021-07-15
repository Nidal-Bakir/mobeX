import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get_it/get_it.dart';
import 'package:mobox/core/auth/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/error/exception.dart';
import 'package:mobox/core/model/user_store.dart';
import 'package:mobox/core/utils/global_function.dart';
import 'package:mobox/core/widget/no_data.dart';
import 'package:mobox/core/widget/retry_button.dart';
import 'package:mobox/features/purchase_orders/data/model/purchase_orders.dart';
import 'package:mobox/features/purchase_orders/presentation/manager/purchase_order_bloc/purchase_order_bloc.dart';
import 'package:mobox/features/purchase_orders/presentation/manager/purchase_orders_bloc/purchase_orders_bloc.dart';
import 'package:mobox/features/purchase_orders/presentation/widgets/purchase_order_item.dart';
import 'package:mobox/features/purchase_orders/presentation/widgets/purchase_order_item_with_date.dart';
import 'package:url_launcher/url_launcher.dart';

class PurchaseOrdersTab extends StatefulWidget {
  const PurchaseOrdersTab({Key? key}) : super(key: key);

  @override
  _PurchaseOrdersTabState createState() => _PurchaseOrdersTabState();
}

class _PurchaseOrdersTabState extends State<PurchaseOrdersTab> {
  late final TapGestureRecognizer _tapGestureRecognizer =
      TapGestureRecognizer();

  @override
  void initState() {
    context.read<PurchaseOrdersBloc>().add(PurchaseOrdersNextPageLoaded());
    _tapGestureRecognizer.onTap = () async {
      // TODO : use our url
      if (await canLaunch('http://mobox.com')) {
        await launch('http://mobox.com');
      }
    };
    super.initState();
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userStore = context.select<AuthBloc, UserStore?>((AuthBloc auth) =>
        (auth.state as AuthLoadUserProfileSuccess).userProfile.userStore);

    if (userStore == null) {
      return Center(
        child: Text.rich(
          TextSpan(
            text: "You do not have a store account",
            children: <InlineSpan>[
              TextSpan(
                text: 'Click here to create one',
                recognizer: _tapGestureRecognizer,
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Builder(
      builder: (context) =>
          BlocBuilder<PurchaseOrdersBloc, PurchaseOrdersState>(
        builder: (context, state) {
          if (state is PurchaseOrdersLoadSuccess) {
            return _PurchaseOrdersList(
              purchaseOrders: state.purchaseOrders,
            );
          } else if (state is PurchaseOrdersLoadFailure) {
            return _PurchaseOrdersList(
              purchaseOrders: state.purchaseOrders,
              withRetryButton: true,
            );
          } else if (state is PurchaseOrdersLoadMoreDataInProgress) {
            return _PurchaseOrdersList(
              purchaseOrders: state.purchaseOrders,
              withLoadingIndicator: true,
            );
          } else if (state is PurchaseOrdersNoPurchaseOrders) {
            return NoData(
              vertical: true,
              title: 'There is no Purchase order at this moment!',
            );
          } else if (state is PurchaseOrdersInProgress) {
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

class _PurchaseOrdersList extends StatelessWidget {
  final List<PurchaseOrder> purchaseOrders;
  final bool withRetryButton;
  final bool withLoadingIndicator;
  final int listLength;

  const _PurchaseOrdersList({
    Key? key,
    required this.purchaseOrders,
    this.withRetryButton = false,
    this.withLoadingIndicator = false,
  })  : listLength = (withRetryButton || withLoadingIndicator)
            ? purchaseOrders.length + 1
            : purchaseOrders.length,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) => notificationListener(
        notification: notification,
        onNotify: () => context
            .read<PurchaseOrdersBloc>()
            .add(PurchaseOrdersNextPageLoaded()),
      ),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          if ((withRetryButton || withLoadingIndicator) &&
              index == listLength) {
            if (withLoadingIndicator)
              return LinearProgressIndicator();
            else
              return Center(
                child: RetryTextButton(
                  onClickCallback: () => context
                      .read<PurchaseOrdersBloc>()
                      .add(PurchaseOrdersNextPageLoaded()),
                ),
              );
          }
          if (index == 0 ||
              _moreThenOneDayDiff(purchaseOrders[index].orderTime,
                  purchaseOrders[index - 1].orderTime)) {
            return BlocProvider<PurchaseOrderBloc>(
              child: PurchaseOrderItemWithDate(
                orderDate: purchaseOrders[index].orderTime,
              ),
              create: (context) => GetIt.I.get(param1: purchaseOrders[index]),
            );
          } else {
            // range in tha same day put them together
            return BlocProvider<PurchaseOrderBloc>(
              child: PurchaseOrderItem(),
              create: (context) => GetIt.I.get(param1: purchaseOrders[index]),
            );
          }
        },
        itemCount: listLength,
      ),
    );
  }

  bool _moreThenOneDayDiff(DateTime dateTime1, DateTime dateTime2) =>
      dateTime1.difference(dateTime2).inDays > 0 ||
      dateTime1.difference(dateTime2).inDays < 0;
}
