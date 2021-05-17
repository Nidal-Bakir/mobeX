import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobox/core/model/store_model.dart';
import 'package:mobox/features/search/repository/search_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'store_search_event.dart';

part 'store_search_state.dart';

class StoreSearchBloc extends Bloc<StoreSearchEvent, StoreSearchState> {
  SearchRepository searchRepository;

  StoreSearchBloc({required this.searchRepository})
      : super(StoreSearchInitial());

  @override
  Stream<Transition<StoreSearchEvent, StoreSearchState>> transformEvents(
          Stream<StoreSearchEvent> events,
          TransitionFunction<StoreSearchEvent, StoreSearchState>
              transitionFn) =>
      super.transformEvents(
        events.debounce((event) {
          if (event is StoreSearchMoreDataLoaded) {
            return Stream.value(event)
                .debounceTime(Duration(milliseconds: 150));
          } else if (event is StoreSearchLoaded) {
            return Stream.value(event)
                .debounceTime(Duration(milliseconds: 300));
          }
          return Stream.value(event);
        }),
        transitionFn,
      );

  List<Store> getCurrentStoreListFromCurrentState() {
    var currentState = state;
    List<Store> _storeList = [];
    if (currentState is StoreSearchLoadSuccess ||
        currentState is StoreSearchMoreDataInProgress) {
      // this is necessary because dart cast the currentState if check for two subclasses to it's there father
      // in this case the ProductState and it doesn't have productList member

      if (currentState is StoreSearchLoadSuccess) {
        _storeList = currentState.storeList;
      } else if (currentState is StoreSearchMoreDataInProgress) {
        _storeList = currentState.storeList;
      }
    }
    return _storeList;
  }

  @override
  Stream<StoreSearchState> mapEventToState(
    StoreSearchEvent event,
  ) async* {
    if (event is StoreSearchLoaded) {
      yield* _storeSearchLoadedHandler(event.storeName);
    } else if (event is StoreSearchLoadRetried) {
      yield* _storeSearchLoadRetriedHandler(event.storeName);
    } else if (event is StoreSearchMoreDataLoaded) {
      yield* _storeSearchMoreDataLoadedHandler(event.storeName);
    } else if (event is StoreSearchInitialed) {
      yield StoreSearchInitial();
    }
  }

  Stream<StoreSearchState> _storeSearchLoadedHandler(String storeName) =>
      _storeHandler(storeName);

  Stream<StoreSearchState> _storeSearchLoadRetriedHandler(String storeName) =>
      _storeHandler(storeName);

  Stream<StoreSearchState> _storeSearchMoreDataLoadedHandler(
      String storeName) async* {
    yield StoreSearchMoreDataInProgress(
        storeList: getCurrentStoreListFromCurrentState());

    yield* _storeHandler(storeName);
  }

  Stream<StoreSearchState> _storeHandler(String storeName) async* {
    var storeList = getCurrentStoreListFromCurrentState();
    yield* searchRepository
        .searchStoresByTitle(
            storeName: storeName, paginationCount: storeList.length)
        .bufferCount(10)
        .scan<List<Store>>(
            (acc, current, index) => [...acc ?? []]..addAll(current), storeList)
        .map((event) => event.isEmpty
            ? StoreSearchLoadNoData()
            : StoreSearchLoadSuccess(storeList: event))
        .startWith(StoreSearchInProgress())
        .onErrorReturn(StoreSearchLoadFailure(storeList: storeList));
  }
}
