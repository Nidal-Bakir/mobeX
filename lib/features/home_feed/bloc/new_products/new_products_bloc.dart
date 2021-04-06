import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobox/core/model/product_model.dart';

part 'new_products_event.dart';
part 'new_products_state.dart';

class NewProductsBloc extends Bloc<NewProductsEvent, NewProductsState> {
  NewProductsBloc() : super(NewProductsInProgress());

  @override
  Stream<NewProductsState> mapEventToState(
    NewProductsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
