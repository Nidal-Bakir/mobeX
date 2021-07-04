part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();
}

class OrderInProgress extends OrderState {
  const OrderInProgress();

  @override
  List<Object> get props => [];
}

class OrderNothingPlaced extends OrderState {
  const OrderNothingPlaced();

  @override
  List<Object> get props => [];
}


class OrderLoadSuccess extends OrderState {
  final List<Order> orders;

  const OrderLoadSuccess(this.orders);

  @override
  List<Object> get props => [orders];
}
class OrderLoadMoreDataInProgress extends OrderState {
  final List<Order> orders;

  const OrderLoadMoreDataInProgress(this.orders);

  @override
  List<Object> get props => [orders];
}
class OrderLoadFailure extends OrderState {
  final List<Order> orders;

  const OrderLoadFailure(this.orders);

  @override
  List<Object> get props => [orders];
}
