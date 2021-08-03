import 'package:mobox/core/auth/data/data_source/local/local_auth.dart';
import 'package:mobox/core/auth/data/data_source/remote/remote_auth.dart';
import 'package:mobox/core/model/user_profiel.dart';

class AuthRepo {
  final LocalAuth localAuth;
  final RemoteAuth remoteAuth;

  AuthRepo({required this.localAuth, required this.remoteAuth});

  UserProfile? getUserProfile() {
    return localAuth.getUserProfile();
  }

  Future<UserProfile> login(
      {required String userName, required String password}) async {
    var userProfile =
        await remoteAuth.login(userName: userName, password: password);
    localAuth.storeUserProfile(userProfile);
    return userProfile;
  }

  Future<UserProfile> getUpdatedUserProfile({required String token}) async {
    var userProfile = await remoteAuth.getUpdatedUserProfile(token: token);
    localAuth.storeUserProfile(userProfile);
    return userProfile;
  }

  UserProfile getGuestUserProfile() => localAuth.generateDummyUserData();
}
