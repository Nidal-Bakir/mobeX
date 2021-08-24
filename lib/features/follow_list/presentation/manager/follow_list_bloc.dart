import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobox/core/model/store_model.dart';
import 'package:mobox/features/follow_list/repositories/follow_list_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'follow_list_event.dart';
part 'follow_list_state.dart';

class FollowListBloc extends Bloc<FollowListEvent, FollowListState> {
  final FollowListRepository _repository;

  FollowListBloc(this._repository) : super(FollowListInProgress());

  @override
  Stream<Transition<FollowListEvent, FollowListState>> transformEvents(
          Stream<FollowListEvent> events,
          TransitionFunction<FollowListEvent, FollowListState> transitionFn) =>
      super.transformEvents(
        events is FollowListMoreDataLoaded
            ? events.debounceTime(Duration(milliseconds: 200))
            : events,
        transitionFn,
      );

  @override
  Stream<FollowListState> mapEventToState(
    FollowListEvent event,
  ) async* {
    if (event is FollowListLoaded) {
      yield* _followListLoadedHandler();
    } else if (event is FollowListLoadRetried) {
      yield* _followListLoadRetriedHandler();
    } else if (event is FollowListMoreDataLoaded) {
      yield* _followListMoreDataLoadedHandler();
    }
  }

  Stream<FollowListState> _followListLoadedHandler() => _followHandler();

  Stream<FollowListState> _followListMoreDataLoadedHandler() =>
      _followHandler();

  Stream<FollowListState> _followListLoadRetriedHandler() => _followHandler();

  Stream<FollowListState> _followHandler() async* {
    yield* _repository
        .getStoresTheUserFollow()
        .bufferCount(10)
        .scan<List<Store>>(
            (acc, current, index) => [...acc ?? []]..addAll(current), [])
        .map((event) =>
            event.isEmpty ? FollowListNoData() : FollowListLoadSuccess(event))
        .onErrorReturn(FollowListLoadFailure());
  }
}
