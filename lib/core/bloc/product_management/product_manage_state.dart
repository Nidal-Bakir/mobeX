part of 'product_manage_bloc.dart';

abstract class ProductManageState extends Equatable {
  const ProductManageState();
}

class ProductManageInitial extends ProductManageState {
  @override
  List<Object> get props => [];
}

class ProductManageInProgress extends ProductManageState {
  @override
  List<Object> get props => [];
}

class ProductManageAddProductSuccess extends ProductManageState {
  final Product product;

  ProductManageAddProductSuccess(this.product);

  @override
  List<Object> get props => [product];
}

class ProductManageAddProductFailure extends ProductManageState {
  ProductManageAddProductFailure();

  @override
  List<Object> get props => [];
}

class ProductManageEditProductSuccess extends ProductManageState {
  final Product product;

  ProductManageEditProductSuccess(this.product);

  @override
  List<Object> get props => [product];
}

class ProductManageEditProductFailure extends ProductManageState {
  const ProductManageEditProductFailure();

  @override
  List<Object> get props => [];
}

class ProductManageDeleteProductSuccess extends ProductManageState {
  final Product product;

  ProductManageDeleteProductSuccess(this.product);

  @override
  List<Object> get props => [product];
}

class ProductManageDeleteProductFailure extends ProductManageState {
  const ProductManageDeleteProductFailure();

  @override
  List<Object> get props => [];
}
