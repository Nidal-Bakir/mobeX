part of 'purchase_orders_bloc.dart';

abstract class PurchaseOrdersEvent extends Equatable {
  const PurchaseOrdersEvent();
}

class PurchaseOrdersNextPageLoaded extends PurchaseOrdersEvent {
  const PurchaseOrdersNextPageLoaded();

  @override
  List<Object?> get props => [];
}

class PurchaseOrdersRetry extends PurchaseOrdersEvent {
  const PurchaseOrdersRetry();

  @override
  List<Object?> get props => [];
}
