import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobox/core/error/exception.dart';
import 'package:mobox/features/categories/repository/categories_repository.dart';

part 'categories_event.dart';

part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepository categoriesRepository;

  CategoriesBloc({required this.categoriesRepository})
      : super(CategoriesLoadInProgress());

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    if (event is CategoriesLoadRetried) {
      yield* _categoriesLoadRetriedHandler();
    } else if (event is CategoriesListLoaded) {
      yield* _categoriesListLoadedHandler();
    }
  }

  Stream<CategoriesState> _categoriesLoadRetriedHandler() async* {
    yield CategoriesLoadInProgress();
    yield* _loadCategoriesList();
  }

  Stream<CategoriesState> _categoriesListLoadedHandler() async* {
    yield* _loadCategoriesList();
  }

  Stream<CategoriesState> _loadCategoriesList() async* {
    try {
      var categoriesList = await categoriesRepository.getCategoriesList();
      if (categoriesList.isEmpty) {
        yield CategoriesLoadNoData();
      } else {
        yield CategoriesLoadSuccess(categoriesList: categoriesList);
      }
    } on ConnectionExceptionWithData catch (e) {
      if ((e.data as List<String>).isEmpty) {
        yield CategoriesLoadNoData();
      }else{
        yield CategoriesLoadFailure(categoriesList: e.data as List<String>);

      }
    }
  }
}
