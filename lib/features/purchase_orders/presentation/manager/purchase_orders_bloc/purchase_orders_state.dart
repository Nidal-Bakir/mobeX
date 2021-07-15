part of 'purchase_orders_bloc.dart';

abstract class PurchaseOrdersState extends Equatable {
  const PurchaseOrdersState();
}

class PurchaseOrdersInProgress extends PurchaseOrdersState {
  const PurchaseOrdersInProgress();

  @override
  List<Object> get props => [];
}

class PurchaseOrdersLoadSuccess extends PurchaseOrdersState {
  final List<PurchaseOrder> purchaseOrders;

  const PurchaseOrdersLoadSuccess(this.purchaseOrders);

  @override
  List<Object?> get props => [purchaseOrders];
}

class PurchaseOrdersLoadFailure extends PurchaseOrdersState {
  final List<PurchaseOrder> purchaseOrders;

  const PurchaseOrdersLoadFailure(this.purchaseOrders);

  @override
  List<Object?> get props => [purchaseOrders];
}

class PurchaseOrdersNoPurchaseOrders extends PurchaseOrdersState {
  const PurchaseOrdersNoPurchaseOrders();

  @override
  List<Object?> get props => [];
}

class PurchaseOrdersLoadMoreDataInProgress extends PurchaseOrdersState {
  final List<PurchaseOrder> purchaseOrders;

  const PurchaseOrdersLoadMoreDataInProgress(this.purchaseOrders);

  @override
  List<Object?> get props => [purchaseOrders];
}
