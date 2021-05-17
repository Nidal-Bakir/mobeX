part of 'store_search_bloc.dart';

abstract class StoreSearchState extends Equatable {
  const StoreSearchState();
}

class StoreSearchInitial extends StoreSearchState {
  const StoreSearchInitial();

  @override
  List<Object> get props => [];
}

class StoreSearchInProgress extends StoreSearchState {
  @override
  List<Object> get props => [];
}

class StoreSearchLoadSuccess extends StoreSearchState {
  final List<Store> storeList;

  const StoreSearchLoadSuccess({required this.storeList});

  @override
  List<Object?> get props => [storeList];
}

class StoreSearchLoadFailure extends StoreSearchState {
  final List<Store> storeList;

  const StoreSearchLoadFailure({required this.storeList});

  @override
  List<Object?> get props => [storeList];
}

class StoreSearchLoadNoData extends StoreSearchState {
  const StoreSearchLoadNoData();

  @override
  List<Object?> get props => [];
}

class StoreSearchMoreDataInProgress extends StoreSearchState {
  final List<Store> storeList;

  const StoreSearchMoreDataInProgress({required this.storeList});

  @override
  List<Object> get props => [storeList];
}
