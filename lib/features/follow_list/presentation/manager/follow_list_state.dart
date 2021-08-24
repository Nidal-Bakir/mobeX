part of 'follow_list_bloc.dart';

abstract class FollowListState extends Equatable {
  const FollowListState();
}

class FollowListInProgress extends FollowListState {
  const FollowListInProgress();

  @override
  List<Object?> get props => [];
}

class FollowListNoData extends FollowListState {
  const FollowListNoData();

  @override
  List<Object?> get props => [];
}

class FollowListLoadSuccess extends FollowListState {
  final List<Store> followList;

  const FollowListLoadSuccess(this.followList);

  @override
  List<Object?> get props => [followList];
}

class FollowListLoadFailure extends FollowListState {
  const FollowListLoadFailure();

  @override
  List<Object?> get props => [];
}
