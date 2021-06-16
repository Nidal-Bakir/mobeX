part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class CartProductAdded extends CartEvent {
  final Product product;

  CartProductAdded(this.product);

  @override
  List<Object?> get props => [product];
}

class CartProductDeleted extends CartEvent {
  final Product product;

  CartProductDeleted(this.product);

  @override
  List<Object?> get props => [product];
}

class CartCheckOutRequested extends CartEvent {
  CartCheckOutRequested();

  @override
  List<Object?> get props => [];
}

class CartQuantityEdited extends CartEvent {
  final Product product;
  final int quantity;

  CartQuantityEdited(this.product, this.quantity);

  @override
  List<Object?> get props => [];
}

class CartAllItemsDeleted extends CartEvent {
  CartAllItemsDeleted();

  @override
  List<Object?> get props => [];
}
