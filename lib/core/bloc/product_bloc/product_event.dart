part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

/// ReRequested the products data from api
class ProductLoadRetried extends ProductEvent {
  @override
  List<Object?> get props => [];
}

/// Requested products data from api
class ProductDataLoaded extends ProductEvent {
  @override
  List<Object?> get props => [];
}

/// load more products from api for infinite scrolling
class ProductMoreDataLoaded extends ProductEvent {
  @override
  List<Object?> get props => [];
}

// send user rate for a product
class ProductRateUpDated extends ProductEvent {
  final double? newRate;
  final double? oldRate;
  final Product product;

  const ProductRateUpDated({
    required this.newRate,
    required this.oldRate,
    required this.product,
  });

  @override
  List<Object?> get props => [oldRate,newRate, product];
}
