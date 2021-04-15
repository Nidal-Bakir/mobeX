part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}
/// ReRequested the CategoriesEvent List from api
class CategoriesLoadRetried extends CategoriesEvent {
  @override
  List<Object?> get props => [];
}

/// Requested Categories List from api
class CategoriesListLoaded extends CategoriesEvent {
  @override
  List<Object?> get props => [];
}
