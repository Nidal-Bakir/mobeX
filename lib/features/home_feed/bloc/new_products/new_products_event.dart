part of 'new_products_bloc.dart';

@immutable
abstract class NewProductsEvent extends Equatable {
  const NewProductsEvent();
}

/// ReRequested the newProducts data from api.
class NewProductsReRequested extends NewProductsEvent {
  @override
  List<Object?> get props => [];
}

/// Added as result of click on product to see more details about it.
class NewProductsProductClicked extends NewProductsEvent {
  final Product product;

  const NewProductsProductClicked({required this.product});

  @override
  List<Object?> get props => [product];
}
