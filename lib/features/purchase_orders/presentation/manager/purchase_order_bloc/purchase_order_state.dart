part of 'purchase_order_bloc.dart';

abstract class PurchaseOrderState extends Equatable {
  final PurchaseOrder purchaseOrder;

  const PurchaseOrderState(this.purchaseOrder);
}

class PurchaseOrderInitial extends PurchaseOrderState {
  const PurchaseOrderInitial(PurchaseOrder purchaseOrder)
      : super(purchaseOrder);

  @override
  List<Object> get props => [purchaseOrder];
}

class PurchaseOrderUpdateStateInProgress extends PurchaseOrderState {
  const PurchaseOrderUpdateStateInProgress(PurchaseOrder purchaseOrder)
      : super(purchaseOrder);

  @override
  List<Object> get props => [purchaseOrder];
}

class PurchaseOrderUpdateStateFailure extends PurchaseOrderState {
  const PurchaseOrderUpdateStateFailure(PurchaseOrder purchaseOrder)
      : super(purchaseOrder);

  @override
  List<Object> get props => [purchaseOrder];
}

class PurchaseOrderUpdateStateSuccess extends PurchaseOrderState {
  const PurchaseOrderUpdateStateSuccess(PurchaseOrder purchaseOrder)
      : super(purchaseOrder);

  @override
  List<Object> get props => [purchaseOrder];
}
