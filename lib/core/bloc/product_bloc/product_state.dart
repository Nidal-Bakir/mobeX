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
