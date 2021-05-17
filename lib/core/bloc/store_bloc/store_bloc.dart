import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobox/core/error/exception.dart';
import 'package:mobox/core/model/store_model.dart';
import 'package:mobox/core/repository/store_repository.dart';

part 'store_event.dart';

part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoreRepository storeRepository;

  StoreBloc({required this.storeRepository}) : super(StoreInitial());

  @override
  Stream<StoreState> mapEventToState(
    StoreEvent event,
  ) async* {
    if (event is StoreFollowStateLoaded) {
      yield* _storeFollowStateLoadedHandler(event.storeUserName);
    } else if (event is StoreFollowStateChanged) {
      yield* _storeFollowStateChangedHandler(
          event.storeUserName, event.isFollowing);
    } else if (event is StoreLoaded) {
      yield* _storeLoadedHandler(event.ownerUserName);
    }
  }

  Stream<StoreState> _storeFollowStateLoadedHandler(
      String storeUserName) async* {
    try {
      var followState = await storeRepository.getFollowStateForStore(
          storeUserName: storeUserName);
      yield StoreFollowStateLoadSuccess(isFollowing: followState);
    } on ConnectionException catch (e) {
      yield StoreFollowStateLoadFailure();
    }
  }

  Stream<StoreState> _storeFollowStateChangedHandler(
      String storeUserName, bool isFollowing) async* {
    try {
      storeRepository.setFollowStateForStore(
          storeUserName: storeUserName, followState: isFollowing);

      yield StoreFollowStateChangSuccess(isFollowing: isFollowing);
    } on ConnectionException catch (e) {
      yield StoreFollowStateChangeFailure();
    }
  }

  Stream<StoreState> _storeLoadedHandler(String ownerUserName) async* {
    try {
      var store = await storeRepository.getStoreInfoFromStoreUserName(
          storeUserName: ownerUserName);
      yield StoreLoadSuccess(store: store);
    } on ConnectionException catch (e) {
      yield StoreLoadFailure();
    }
  }
}
