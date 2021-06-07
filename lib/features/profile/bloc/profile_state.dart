part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}
class ProfileInProgress extends ProfileState {
  @override
  List<Object> get props => [];
}
class ProfileChangesUploadSuccess extends ProfileState {
  @override
  List<Object> get props => [];
}
class ProfileChangesUploadFailure extends ProfileState {
  @override
  List<Object> get props => [];
}