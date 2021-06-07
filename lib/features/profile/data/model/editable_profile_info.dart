import 'package:mobox/core/model/user_profiel.dart';
import 'package:mobox/core/utils/address.dart';

class EditableProfileInfo {
  final Address address;
  final String storeName;
  final String bio;
  final String profileImagePath;

  EditableProfileInfo({
    required this.address,
    required this.bio,
    required this.storeName,
    required this.profileImagePath,
  });

  EditableProfileInfo.fromProfile(UserProfile userProfile)
      : this.address = userProfile.address,
        this.bio = userProfile.userStore?.bio ?? '',
        this.profileImagePath = userProfile.profileImage,
        this.storeName =
            userProfile.userStore?.storeName ?? 'You donn\'t have a store';

  EditableProfileInfo copyWith({
    Address? address,
    String? storeName,
    String? bio,
    String? profileImagePath,
  }) {
    return EditableProfileInfo(
        address: address ?? this.address,
        bio: bio ?? this.bio,
        profileImagePath: profileImagePath ?? this.profileImagePath,
        storeName: storeName ?? this.storeName);
  }

  bool shareSameDataWithUserProfile(UserProfile other) {
    return profileImagePath == other.profileImage &&
        address == other.address &&
        bio == other.userStore?.bio &&
        storeName == other.userStore?.storeName;
  }
}
