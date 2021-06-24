import 'package:equatable/equatable.dart';

class TotalComputation extends Equatable {
  final int totalQuantity;
  final double totalPrice;

  TotalComputation(this.totalQuantity, this.totalPrice);

  @override
  List<Object?> get props => [totalPrice, totalQuantity];
}
