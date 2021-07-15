import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobox/features/purchase_orders/data/model/purchase_orders.dart';
import 'package:mobox/features/purchase_orders/repositories/purchase_orders_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'purchase_orders_event.dart';

part 'purchase_orders_state.dart';

class PurchaseOrdersBloc
    extends Bloc<PurchaseOrdersEvent, PurchaseOrdersState> {
  final PurchaseOrdersRepository _repository;

  PurchaseOrdersBloc(this._repository) : super(PurchaseOrdersInProgress());

  @override
  Stream<Transition<PurchaseOrdersEvent, PurchaseOrdersState>> transformEvents(
      Stream<PurchaseOrdersEvent> events, transitionFn) {
    return super.transformEvents(events.debounce((event) {
      if (event is PurchaseOrdersNextPageLoaded) {
        return Stream.value(event).debounceTime(Duration(milliseconds: 300));
      }
      return Stream.value(events);
    }), transitionFn);
  }

  @override
  Stream<PurchaseOrdersState> mapEventToState(
    PurchaseOrdersEvent event,
  ) async* {
    if (event is PurchaseOrdersRetry) {
      yield* _purchaseOrdersRetryHandler();
    } else if (event is PurchaseOrdersNextPageLoaded) {
      yield* _purchaseOrdersNextPageLoadedHandler();
    }
  }

  Stream<PurchaseOrdersState> _purchaseOrdersRetryHandler() => _loadOrders();

  Stream<PurchaseOrdersState> _purchaseOrdersNextPageLoadedHandler() =>
      _loadOrders();

  Stream<PurchaseOrdersState> _loadOrders() async* {
    yield* _yieldMoreDataInProgressState();

    yield* _repository
        .getPurchaseOrders()
        .bufferCount(5)
        .scan<List<PurchaseOrder>>(
            (acc, orders, index) => [...acc ?? []]..addAll(orders), [])
        .map<PurchaseOrdersState>((purchaseOrdersList) =>
            PurchaseOrdersLoadSuccess(purchaseOrdersList))
        .startWith(PurchaseOrdersNoPurchaseOrders())
        .onErrorReturn(PurchaseOrdersLoadFailure(
            await _repository.getLocalCachedPurchasedOrders().toList()));
  }

  /// Show Progress indicator in the end of the list,
  /// If there is a data (purchaseOrders) and the state is loadSuccess.
  ///
  /// Wouldn't yield anything if the mentioned conditions unsatisfiable
  Stream<PurchaseOrdersState> _yieldMoreDataInProgressState() async* {
    List<PurchaseOrder> oldTempPurchaseOrders = [];
    var currentState = state;
    if (currentState is PurchaseOrdersLoadSuccess &&
        currentState.purchaseOrders.isNotEmpty) {
      oldTempPurchaseOrders = currentState.purchaseOrders;
      yield PurchaseOrdersLoadMoreDataInProgress(oldTempPurchaseOrders);
    }
  }
}
