import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobox/core/model/order_item.dart';
import 'package:mobox/features/purchase_orders/data/model/purchase_orders.dart';
import 'package:mobox/features/purchase_orders/repositories/purchase_orders_repository.dart';

part 'purchase_order_event.dart';

part 'purchase_order_state.dart';

class PurchaseOrderBloc extends Bloc<PurchaseOrderEvent, PurchaseOrderState> {
  final PurchaseOrder _purchaseOrder;
  final PurchaseOrdersRepository _repository;

  PurchaseOrderBloc(this._purchaseOrder, this._repository)
      : super(PurchaseOrderInitial(_purchaseOrder));

  @override
  Stream<PurchaseOrderState> mapEventToState(
    PurchaseOrderEvent event,
  ) async* {
    if (event is PurchaseOrderStateUpdated) {
      yield* _purchaseOrderStateUpdatedHandler(
          event.purchaseOrder, event.newState);
    }
  }

  Stream<PurchaseOrderState> _purchaseOrderStateUpdatedHandler(
      PurchaseOrder purchaseOrder, OrderItemState newState) async* {
    yield PurchaseOrderUpdateStateInProgress(_purchaseOrder);
    var isSuccess =
        await _repository.updatePurchaseOrderState(purchaseOrder, newState);
    if (isSuccess) {
      yield PurchaseOrderUpdateStateSuccess(_purchaseOrder
          .copyWithNewOrderState(orderItemState: newState) as PurchaseOrder);
    } else {
      yield PurchaseOrderUpdateStateFailure(_purchaseOrder);
    }
  }
}
