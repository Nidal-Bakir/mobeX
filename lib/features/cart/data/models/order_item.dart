import 'package:equatable/equatable.dart';
import 'package:mobox/core/model/product_model.dart';

class OrderItem extends Equatable {
  final Product product;
  final int quantity;

  OrderItem(this.product, this.quantity);

  Map<String, dynamic> toMap() =>
      {'product': product.toMap(), 'quantity': quantity};

  @override
  List<Object?> get props => [product, quantity];

  OrderItem copyWith({Product? product, int? quantity}) =>
      OrderItem(product ?? this.product, quantity ?? this.quantity);
}
