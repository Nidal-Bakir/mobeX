part of 'purchase_order_bloc.dart';

abstract class PurchaseOrderEvent extends Equatable {
  const PurchaseOrderEvent();
}
class PurchaseOrderStateUpdated extends PurchaseOrderEvent {
  final PurchaseOrder purchaseOrder;
  final OrderItemState newState;

  const PurchaseOrderStateUpdated(this.purchaseOrder, this.newState);

  @override
  List<Object?> get props => [purchaseOrder, newState];
}
