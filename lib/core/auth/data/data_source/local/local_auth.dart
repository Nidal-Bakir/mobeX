import 'dart:convert';

import 'package:mobox/core/model/user_profiel.dart';
import 'package:mobox/core/utils/address.dart';
import 'package:mobox/core/utils/const_data.dart';
import 'package:mobox/core/utils/shared_initializer.dart';

abstract class LocalAuth {
  UserProfile? getUserProfile();

  void storeUserProfile(UserProfile userProfile);

  UserProfile generateDummyUserData();
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

  @override
  UserProfile generateDummyUserData() {
    return UserProfile(userName: '00000',
        token: ConstData.guestDummyToken,
        balance: 0.0,
        profileImage: 'assets/images/productimg2.png',
        phone: '0000000000',
        address: Address('your city', 'your st'),
        firstName: 'guest',
        lastName: 'guest',
        accountStatus: AccountStatus.active);
  }
}
