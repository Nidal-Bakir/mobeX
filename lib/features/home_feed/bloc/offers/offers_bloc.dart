import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobox/core/model/product_model.dart';

part 'offers_event.dart';
part 'offers_state.dart';

class OffersBloc extends Bloc<OffersEvent, OffersState> {
  OffersBloc() : super(OffersInProgress());

  @override
  Stream<OffersState> mapEventToState(
    OffersEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
