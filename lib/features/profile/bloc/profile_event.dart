part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileInfoEdited extends ProfileEvent {
  final EditableProfileInfo editableProfileInfo;
  final UserProfile userProfile;

  ProfileInfoEdited(this.editableProfileInfo, this.userProfile);

  @override
  List<Object?> get props => [editableProfileInfo];
}

