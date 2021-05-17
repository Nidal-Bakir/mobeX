part of 'store_bloc.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();
}

class StoreFollowStateLoaded extends StoreEvent {
  final String storeUserName;

  const StoreFollowStateLoaded({required this.storeUserName});

  @override
  List<Object?> get props => [storeUserName];
}

class StoreFollowStateChanged extends StoreEvent {
  final String storeUserName;
  final bool isFollowing;

  const StoreFollowStateChanged(
      {required this.isFollowing, required this.storeUserName});

  @override
  List<Object?> get props => [storeUserName, isFollowing];
}

class StoreLoaded extends StoreEvent {
  final String ownerUserName;

  StoreLoaded({required this.ownerUserName});

  @override
  List<Object?> get props => [ownerUserName];
}
