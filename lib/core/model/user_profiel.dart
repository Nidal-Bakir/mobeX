import 'package:equatable/equatable.dart';
import 'package:mobox/core/model/user_store.dart';
import 'package:mobox/core/utils/address.dart';

enum AccountStatus { active, suspend }

class UserProfile extends Equatable {
  final String userName;
  final String token;
  final double balance;
  final String profileImage;
  final String phone;
  final Address address;
  final String firstName;
  final String lastName;
  final AccountStatus accountStatus;
  final UserStore? userStore;

  UserProfile(
      {required this.userName,
      required this.token,
      required this.balance,
      required this.profileImage,
      required this.phone,
      required this.address,
      required this.firstName,
      required this.lastName,
      required this.accountStatus,
      this.userStore});

  @override
  List<Object?> get props => [
        userName,
        token,
        balance,
        profileImage,
        phone,
        address,
        firstName,
        lastName,
        accountStatus,
        userStore
      ];

  factory UserProfile.fromMap(Map jsonMap) {
    return UserProfile(
      userName: jsonMap['user_name'],
      token: jsonMap['token'],
      balance: jsonMap['balance'].toDouble(),
      profileImage: jsonMap['profile_image'],
      phone: jsonMap['phone'],
      address: Address(jsonMap['city'], jsonMap['address']),
      firstName: jsonMap['first_name'],
      lastName: jsonMap['last_name'],
      accountStatus: jsonMap['account_status'] == 'active'
          ? AccountStatus.active
          : AccountStatus.suspend,
      userStore: jsonMap['user_store'] == null
          ? null
          : UserStore.formMap(jsonMap['user_store']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_name': userName,
      'token': token,
      'balance': balance,
      'profile_image': profileImage,
      'phone': phone,
      'city': address.city,
      'address': address.stAddress,
      'first_name': firstName,
      'last_name': lastName,
      'account_status': accountStatus.toString(),
      'user_store': userStore?.toMap()
    };
  }
}
