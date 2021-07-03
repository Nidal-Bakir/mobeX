part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}



class OrderNextPageLoaded extends OrderEvent {
  @override
  List<Object?> get props => [];
}

/// added when the user checkout successfully and the order placed
class OrderNewOrderPlaced extends OrderEvent {
  final Order order;

 const OrderNewOrderPlaced(this.order);

  @override
  List<Object?> get props => [order];
}
