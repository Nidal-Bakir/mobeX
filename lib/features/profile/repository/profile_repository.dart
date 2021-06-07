import 'package:mobox/core/model/user_profiel.dart';
import 'package:mobox/features/profile/data/remote/remote_profile_data_source.dart';
import 'package:mobox/features/profile/data/model/editable_profile_info.dart';

class ProfileRepository {
  final RemoteProfileDataSource _remote;

  ProfileRepository({required RemoteProfileDataSource remoteProfileDataSource})
      : _remote = remoteProfileDataSource;

  Future<bool> changeProfileInfo(
          EditableProfileInfo newProfileInfo, UserProfile userProfile) async =>
      _remote.changeProfileInfo(newProfileInfo, userProfile);
}
