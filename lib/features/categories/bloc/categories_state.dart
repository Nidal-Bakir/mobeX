part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
}

class CategoriesLoadInProgress extends CategoriesState {
  @override
  List<Object> get props => [];

  const CategoriesLoadInProgress();
}

class CategoriesLoadNoData extends CategoriesState {
  @override
  List<Object?> get props => [];
}

class CategoriesLoadSuccess extends CategoriesState {
  final List<String> categoriesList;

  const CategoriesLoadSuccess({required this.categoriesList});

  @override
  List<Object?> get props => [categoriesList];
}

class CategoriesLoadFailure extends CategoriesState {
  final List<String> categoriesList;

  const CategoriesLoadFailure({required this.categoriesList});

  @override
  List<Object?> get props => [categoriesList];
}
