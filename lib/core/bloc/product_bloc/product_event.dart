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
  List<Object?> get props => [oldRate, newRate, product];
}

class ProductsSearchLoaded extends ProductEvent {
  final String productName;
  final double? priceLessThenOrEqual;

  const ProductsSearchLoaded({
    required this.productName,
    this.priceLessThenOrEqual,
  });

  @override
  List<Object?> get props => [productName, priceLessThenOrEqual];
}

class ProductSearchInitialed extends ProductEvent {
  @override
  List<Object?> get props => [];

  const ProductSearchInitialed();
}

class ProductSearchLoadRetried extends ProductEvent {
  final String productName;
  final double? priceLessThenOrEqual;

  const ProductSearchLoadRetried({
    required this.productName,
    this.priceLessThenOrEqual,
  });

  @override
  List<Object?> get props => [productName, priceLessThenOrEqual];
}

/// load more products from api for search infinite scrolling
class ProductMoreSearchDataLoaded extends ProductEvent {
  final String productName;
  final double? priceLessThenOrEqual;

  const ProductMoreSearchDataLoaded({
    required this.productName,
    this.priceLessThenOrEqual,
  });

  @override
  List<Object?> get props => [productName, priceLessThenOrEqual];
}
// when store management bloc add new product
class ProductAdded extends ProductEvent {
  final Product _product;

  ProductAdded(this._product);

  List<Object?> get props => [_product];
}
// when store management bloc edit a product
class ProductEdited extends ProductEvent {
  final Product _product;

  ProductEdited(this._product);

  List<Object?> get props => [_product];
}
// when store management bloc delete a product
class ProductDeleted extends ProductEvent {
  final Product _product;

  ProductDeleted(this._product);

  List<Object?> get props => [_product];
}
