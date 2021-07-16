import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobox/core/model/editable_profile_info.dart';
import 'package:mobox/features/create_store/repositories/create_store_repository.dart';

part 'create_store_event.dart';

part 'create_store_state.dart';

class CreateStoreBloc extends Bloc<CreateStoreEvent, CreateStoreState> {
  final CreateStoreRepository _repository;

  CreateStoreBloc(this._repository) : super(CreateStoreInitial());

  @override
  Stream<CreateStoreState> mapEventToState(
    CreateStoreEvent event,
  ) async* {
    if (event is CreateStoreRequested) {
      yield* _createStoreRequestedHandler(event.profileInfo);
    }
  }

  Stream<CreateStoreState> _createStoreRequestedHandler(
      EditableProfileInfo profileInfo) async* {
    yield CreateStoreInProgress();
    var isSuccess = await _repository.createStore(profileInfo);
    if (isSuccess)
      yield CreateStoreSuccess();
    else
      yield CreateStoreFailure();
  }
}
