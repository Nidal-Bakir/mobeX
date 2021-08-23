part of 'follow_list_bloc.dart';

abstract class FollowListEvent extends Equatable {
  const FollowListEvent();
}

class FollowListLoaded extends FollowListEvent {
  const FollowListLoaded();

  @override
  List<Object?> get props => [];
}

class FollowListLoadRetried extends FollowListEvent {
  const FollowListLoadRetried();

  @override
  List<Object?> get props => [];
}

class FollowListMoreDataLoaded extends FollowListEvent {
  const FollowListMoreDataLoaded();

  @override
  List<Object?> get props => [];
}
