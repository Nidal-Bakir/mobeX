part of 'product_manage_bloc.dart';

abstract class ProductManageEvent extends Equatable {
  const ProductManageEvent();
}

class ProductManageProductAdded extends ProductManageEvent {
  final EditableProductInfo product;

  ProductManageProductAdded(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductManageProductEdited extends ProductManageEvent {
  final Product product;
  final EditableProductInfo editableProductInfo;

  ProductManageProductEdited(this.product, this.editableProductInfo);

  @override
  List<Object?> get props => [product, editableProductInfo];
}

class ProductManageProductDeleted extends ProductManageEvent {
  final Product product;

  ProductManageProductDeleted(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductManageResetState extends ProductManageEvent {
  const ProductManageResetState();

  @override
  List<Object?> get props => [];
}
