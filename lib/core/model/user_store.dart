import 'package:equatable/equatable.dart';

class UserStore extends Equatable {
  final String storeName;
  final double frozenAssets;
  final double availableAssets;
  final double overAllProfit;

  final String bio;

  UserStore({
    required this.frozenAssets,
    required this.availableAssets,
    required this.overAllProfit,
    required this.storeName,
    required this.bio,
  });

  @override
  List<Object?> get props => [
        storeName,
        bio,
        availableAssets,
        frozenAssets,
        overAllProfit,
      ];

  factory UserStore.formMap(Map<String, dynamic> jsonMap) => UserStore(
        storeName: jsonMap['store_name'],
        bio: jsonMap['bio'],
        availableAssets: jsonMap['available_assets'].toDouble(),
        frozenAssets: jsonMap['frozen_assets'].toDouble(),
        overAllProfit: jsonMap['over_all_profit'].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'store_name': storeName,
        'bio': bio,
        'available_assets': availableAssets,
        'frozen_assets': frozenAssets,
        'over_all_profit': overAllProfit
      };
}
