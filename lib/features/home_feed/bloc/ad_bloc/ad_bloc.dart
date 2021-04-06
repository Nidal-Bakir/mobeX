import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobox/core/model/product_model.dart';

part 'ad_event.dart';
part 'ad_state.dart';

class AdBloc extends Bloc<AdEvent, AdState> {
  AdBloc() : super(AdInProgress());

  @override
  Stream<AdState> mapEventToState(
    AdEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
