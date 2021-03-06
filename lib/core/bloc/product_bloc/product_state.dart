part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductInProgress extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductMoreInProgress extends ProductState {
  final List<Product> productList;

  const ProductMoreInProgress({required this.productList});

  @override
  List<Object> get props => [productList];
}

class ProductLoadSuccess extends ProductState {
  final List<Product> productList;

  const ProductLoadSuccess({required this.productList});

  @override
  List<Object?> get props => [productList];
}

class ProductLoadFailure extends ProductState {
  final List<Product> productList;

  const ProductLoadFailure({required this.productList});

  @override
  List<Object?> get props => [productList];
}

class ProductNoData extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductRateSuccess extends ProductState {
  final double? newUserRate;
  final double newProductRateFromAPI;

  const ProductRateSuccess(this.newUserRate, this.newProductRateFromAPI);

  @override
  List<Object?> get props => [];
}

class ProductRateFailure extends ProductState {
  const ProductRateFailure();

  @override
  List<Object?> get props => [];
}

/// show search tip in the search screen
class ProductSearchInitial extends ProductState {
  const ProductSearchInitial();

  @override
  List<Object> get props => [];
}
