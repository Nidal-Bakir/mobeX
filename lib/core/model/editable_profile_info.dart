import 'package:equatable/equatable.dart';
import 'package:mobox/core/model/user_profiel.dart';
import 'package:mobox/core/utils/address.dart';

class EditableProfileInfo extends Equatable {
  final Address address;
  final String storeName;
  final String bio;
  final String profileImagePath;

  @override
  List<Object> get props => [address, storeName, bio, profileImagePath];

  EditableProfileInfo({
    required this.address,
    required this.bio,
    required this.storeName,
    required this.profileImagePath,
  });

  EditableProfileInfo.emptyFields()
      : this.address = Address('', ''),
        this.bio = '',
        this.profileImagePath = '',
        this.storeName = '';

  EditableProfileInfo.fromProfile(UserProfile userProfile)
      : this.address = userProfile.address,
        this.bio = userProfile.userStore?.bio ?? '',
        this.profileImagePath = userProfile.profileImage,
        this.storeName =
            userProfile.userStore?.storeName ?? 'You donn\'t have a store';

  Map<String, String> toMap() => {
        "store_name": storeName,
        "bio": bio,
        "city": address.city,
        "address": address.stAddress,
        "profile_image": profileImagePath
      };

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
}
