import 'package:equatable/equatable.dart';

class PurchaserInfo extends Equatable {
  final String city;
  final String address;
  final String fName;
  final String mName;
  final String lName;
  final String phone;

  PurchaserInfo({
    required this.city,
    required this.address,
    required this.fName,
    required this.mName,
    required this.lName,
    required this.phone,
  });

  @override
  List<Object> get props => [
        city,
        address,
        fName,
        mName,
        lName,
        phone,
      ];

  Map<String, String> toMap() => {
        "city": city,
        "address": address,
        "first_name": fName,
        "father_name": mName,
        "last_name": lName,
        "phone": phone,
      };

  factory PurchaserInfo.formJson(Map<String, dynamic> jsonMap) {
    return PurchaserInfo(
      city: jsonMap['city'] as String,
      address: jsonMap['address'] as String,
      fName: jsonMap['first_name'] as String,
      mName: jsonMap['father_name'] as String,
      lName: jsonMap['last_name'] as String,
      phone: jsonMap['phone'] as String,
    );
  }

  String getFullName() => fName + ' ' + mName + ' ' + lName;
}
