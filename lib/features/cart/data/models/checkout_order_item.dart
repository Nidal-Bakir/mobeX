import 'package:equatable/equatable.dart';
import 'package:mobox/core/model/product_model.dart';

class CheckOutOrderItem extends Equatable {
  final Product product;
  final int quantity;

  CheckOutOrderItem(this.product, this.quantity);

  Map<String, dynamic> toMap() =>
      {'product': product.toMap(), 'quantity': quantity};

  @override
  List<Object?> get props => [product, quantity];

  CheckOutOrderItem copyWith({Product? product, int? quantity}) =>
      CheckOutOrderItem(product ?? this.product, quantity ?? this.quantity);
}
