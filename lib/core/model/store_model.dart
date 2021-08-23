import 'package:equatable/equatable.dart';

class Store extends Equatable {
  final String ownerUserName;
  final String storeName;
  final String profileImage;
  final String bio;

  Store({
    required this.ownerUserName,
    required this.storeName,
    required this.profileImage,
    required this.bio,
  });

  @override
  List<Object?> get props => [ownerUserName, storeName, profileImage, bio];

  factory Store.fromMap(Map<String, dynamic> jsonMap) => Store(
        ownerUserName: jsonMap['user_name'],
        storeName: jsonMap['store_name'],
        profileImage: jsonMap['profile_image'],
        bio: jsonMap['bio'],
      );

  Map<String, dynamic> toMap() => {
        'ownerUserName': ownerUserName,
        'storeName': storeName,
        'profileImage': profileImage,
        'bio': bio,
      };
}
