part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}
/// ReRequested the products data from api
class ProductReRequested extends ProductEvent {
  @override
  List<Object?> get props => [];
}
/// Requested products data from api
class ProductDataLoaded extends ProductEvent {
  @override
  List<Object?> get props => [];
}
