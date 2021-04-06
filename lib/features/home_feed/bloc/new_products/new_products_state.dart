part of 'new_products_bloc.dart';

@immutable
abstract class NewProductsState extends Equatable {
  const NewProductsState();
}

class NewProductsInProgress extends NewProductsState {
  @override
 
  List<Object?> get props => [];
}

class NewProductsLoadSuccess extends NewProductsState {
  final List<Product>? newProductsList;

  const NewProductsLoadSuccess({this.newProductsList});

  @override
  List<Object?> get props => [newProductsList];
}

/// Emit when error occur while fetch the data.
///
/// The [newProductsList] member hold the cached data or (null) to indecent there is no cached data
class NewProductsLoadFailure extends NewProductsState {
  final List<Product>? newProductsList;

  const NewProductsLoadFailure({this.newProductsList});

  @override
  List<Object?> get props => [newProductsList];
}
