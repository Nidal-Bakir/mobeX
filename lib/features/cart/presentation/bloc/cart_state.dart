part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartEmpty extends CartState {
  @override
  List<Object> get props => [];
}

class CartInProgress extends CartState {
  @override
  List<Object> get props => [];
}

class CartCheckOutSuccess extends CartState {
  final Order order;

  CartCheckOutSuccess(this.order);

  @override
  List<Object> get props => [order];
}

class CartCheckOutFailure extends CartState {
  @override
  List<Object> get props => [];
}

class CartCheckOutInsufficientBalanceFailure extends CartState {
  @override
  List<Object> get props => [];
}

class CartAddItemSuccess extends CartState {
  final CheckOutOrder checkOutOrder;
  final TotalComputation totalComputation;

  CartAddItemSuccess(this.checkOutOrder, this.totalComputation);

  @override
  List<Object> get props => [checkOutOrder, totalComputation];
}

class CartEditQuantitySuccess extends CartState {
  final CheckOutOrder checkOutOrder;
  final TotalComputation totalComputation;

  CartEditQuantitySuccess(this.checkOutOrder, this.totalComputation);

  @override
  List<Object> get props => [checkOutOrder, totalComputation];
}

class CartDeletedItemSuccess extends CartState {
  final CheckOutOrder checkOutOrder;
  final TotalComputation totalComputation;

  CartDeletedItemSuccess(this.checkOutOrder, this.totalComputation);

  @override
  List<Object> get props => [checkOutOrder, totalComputation];
}
