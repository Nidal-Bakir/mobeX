import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobox/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mobox/features/order/data/models/order.dart';
import 'package:mobox/features/order/data/repositories/order_repository.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _repository;
  final CartBloc _cartBloc;

  OrderBloc(this._repository, this._cartBloc) : super(OrderInProgress()) {
    _cartBloc.stream.listen((cartState) {
      if (cartState is CartCheckOutSuccess) {
        this.add(OrderNewOrderPlaced(cartState.order));
      }
    });
  }

  @override
  Stream<OrderState> mapEventToState(
    OrderEvent event,
  ) async* {
    if (event is OrderNextPageLoaded) {
      yield* _orderNextPageLoadedHandle();
    } else if (event is OrderNewOrderPlaced) {
      yield* _orderNewOrderPlacedHandle(event.order);
    }
  }

  @override
  void onTransition(Transition<OrderEvent, OrderState> transition) {
    super.onTransition(transition);
    print('event : '+transition.event.toString());
    print('currentState: '+transition.currentState.toString());
    print('nextState: '+transition.nextState.toString());

  }

  Stream<OrderState> _orderNextPageLoadedHandle() async* {
    yield* _repository
        .getStreamOfUserOrders()
        .bufferCount(5)
        .scan<List<Order>>(
            (acc, orders, index) => [...acc ?? []]..addAll(orders), [])
        .map((orderList) => orderList.isEmpty
            ? OrderNothingPlaced()
            : OrderLoadSuccess(orderList))
        .onErrorReturn(
            OrderLoadFailure(await _repository.getLocalCachedOrders()));
  }

  /// as response to checkout event form cart bloc add new order to cache
  Stream<OrderState> _orderNewOrderPlacedHandle(Order order) async* {
    _repository.addNewOrder(order);

    yield OrderLoadSuccess(await _repository.getLocalCachedOrders());
  }
}
