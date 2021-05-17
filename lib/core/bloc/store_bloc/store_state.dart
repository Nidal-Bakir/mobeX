part of 'store_bloc.dart';

abstract class StoreState extends Equatable {
  const StoreState();
}

class StoreInitial extends StoreState {
  @override
  List<Object> get props => [];
}

class StoreFollowStateLoadSuccess extends StoreState {
  final bool isFollowing;

  StoreFollowStateLoadSuccess({required this.isFollowing});

  @override
  List<Object> get props => [isFollowing];
}

class StoreFollowStateLoadFailure extends StoreState {
  @override
  List<Object> get props => [];
}

class StoreFollowStateChangSuccess extends StoreState {
  final isFollowing;

  StoreFollowStateChangSuccess({required this.isFollowing});

  @override
  List<Object> get props => [isFollowing];
}

class StoreFollowStateChangeFailure extends StoreState {
  @override
  List<Object> get props => [];
}