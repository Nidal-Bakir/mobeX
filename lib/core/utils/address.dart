import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String city;
  final String stAddress;

  Address(this.city, this.stAddress);

  @override
  String toString() => '$city, $stAddress';

  @override
  List<Object?> get props => [city, stAddress];

  Address copyWith({String? city, String? stAddress}) {
    return Address(city ?? this.city, stAddress ?? this.stAddress);
  }
}
