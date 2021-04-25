import 'dart:convert';

import 'package:mobox/core/auth/data/model/user_profiel.dart';
import 'package:mobox/core/utils/shared_initializer.dart';

abstract class LocalAuth {
  UserProfile? getUserProfile();

  void storeUserProfile(UserProfile userProfile);
}

class LocalAuthImpl extends LocalAuth {
  final SharedInitializer sharedInitializer;

  LocalAuthImpl({required this.sharedInitializer});

  @override
  void storeUserProfile(UserProfile userProfile) {
    sharedInitializer.sharedPreferences
        .setString('userProfile', jsonEncode(userProfile.toMap()));
  }

  @override
  UserProfile? getUserProfile() {
    var userProfile =
        sharedInitializer.sharedPreferences.getString('userProfile');
    if (userProfile == null) return null;
    return UserProfile.fromMap(jsonDecode(userProfile));
  }
}
