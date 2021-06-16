import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobox/core/error/exception.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/features/cart/data/models/check_out_order.dart';
import 'package:mobox/features/cart/data/repositories/cart_repository.dart';
import 'package:mobox/features/cart/util/total_computation.dart';
import 'package:mobox/features/order/data/models/order.dart';
import 'package:mobox/core/utils/dart_extensions.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _repository;

  CartBloc(this._repository) : super(CartEmpty());

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is CartProductAdded) {
      yield* _cartProductAddedHandler(event.product);
    } else if (event is CartProductDeleted) {
      yield* _cartProductDeletedHandler(event.product);
    } else if (event is CartCheckOutRequested) {
      yield* _cartCheckOutRequestedHandler();
    } else if (event is CartQuantityEdited) {
      yield* _cartQuantityEditedHandler(event.product, event.quantity);
    } else if (event is CartAllItemsDeleted) {
      yield* _cartAllItemsDeletedHandler();
    }
  }

  Stream<CartState> _cartProductAddedHandler(Product product) async* {
    _repository.addProduct(product);
    var checkOutOrder = _repository.getCheckOutOrder();
    var totalComputation = getTotalComputation(checkOutOrder);
    yield CartAddItemSuccess(checkOutOrder, totalComputation);
  }

  Stream<CartState> _cartProductDeletedHandler(Product product) async* {
    _repository.deleteProduct(product);
    var checkOutOrder = _repository.getCheckOutOrder();
    if (checkOutOrder.items.isEmpty) {
      yield CartEmpty();
    } else {
      var totalComputation = getTotalComputation(checkOutOrder);
      yield CartDeletedItemSuccess(checkOutOrder, totalComputation);
    }
  }

  Stream<CartState> _cartCheckOutRequestedHandler() async* {
    yield CartInProgress();
    try {
      var order = await _repository.checkOut();
      yield CartCheckOutSuccess(order);
    } on ConnectionException catch (e) {
      yield CartCheckOutFailure();
    } on InsufficientBalance catch (e) {
      yield CartCheckOutInsufficientBalanceFailure();
    }
  }

  Stream<CartState> _cartQuantityEditedHandler(
      Product product, int quantity) async* {
    _repository.editQuantity(product, quantity);
    var checkOutOrder = _repository.getCheckOutOrder();
    var totalComputation = getTotalComputation(checkOutOrder);
    yield CartEditQuantitySuccess(checkOutOrder, totalComputation);
  }

  Stream<CartState> _cartAllItemsDeletedHandler() async* {
    _repository.deleteOrder();
    yield CartEmpty();
  }

  TotalComputation getTotalComputation(CheckOutOrder checkOutOrder) {
    int totalQuantity = checkOutOrder.items.fold(
        0, (previousQuantity, element) => element.quantity + previousQuantity);
    double totalPrice = checkOutOrder.items
        .fold<double>(
            0,
            (previousPrice, element) =>
                (element.product.sale ?? element.product.price) *
                    element.quantity +
                previousPrice)
        .toPrecision(2);
    return TotalComputation(totalQuantity, totalPrice);
  }
}
