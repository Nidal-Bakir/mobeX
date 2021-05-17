part of 'store_search_bloc.dart';

abstract class StoreSearchEvent extends Equatable {
  const StoreSearchEvent();
}

class StoreSearchLoadRetried extends StoreSearchEvent {
  final String storeName;

  const StoreSearchLoadRetried({required this.storeName});

  @override
  List<Object?> get props => [storeName];
}

class StoreSearchLoaded extends StoreSearchEvent {
  final String storeName;

  const StoreSearchLoaded({required this.storeName});

  @override
  List<Object?> get props => [storeName];
}

class StoreSearchInitialed extends StoreSearchEvent {
  @override
  List<Object?> get props => [];

  const StoreSearchInitialed();
}

/// for infinite scrolling
class StoreSearchMoreDataLoaded extends StoreSearchEvent {
  final String storeName;

  const StoreSearchMoreDataLoaded({required this.storeName});

  @override
  List<Object?> get props => [storeName];
}
