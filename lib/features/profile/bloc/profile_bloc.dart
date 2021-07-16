import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobox/core/model/user_profiel.dart';
import 'package:mobox/core/model/editable_profile_info.dart';
import 'package:mobox/features/profile/repository/profile_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository ;

  ProfileBloc(this._profileRepository) : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileInfoEdited) {
      yield ProfileInProgress();
      var success = await _profileRepository
          .changeProfileInfo(event.editableProfileInfo,event.userProfile);
      if (success) {
        yield ProfileChangesUploadSuccess();
      } else {
        ProfileChangesUploadFailure();
      }
    }
  }
}
