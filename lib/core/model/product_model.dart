import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final String storeName;
  final String storeId;
  final String imageUrl;
  final double price;
  final double? sale;
  final double rate;
  final double? myRate;
  final String description;

  Product(
      { required this.id,
      required this.title,
      required this.storeName,
      required this.storeId,
      required this.imageUrl,
      required this.description,
      required this.price,
      required this.sale,
      required this.myRate,
      required this.rate});

  @override
  List<Object?> get props => [
        id,
        storeId,
        storeName,
        imageUrl,
        price,
        sale,
        rate,
        myRate,
        title,
        description
      ];

  factory Product.fromMap(Map<String, dynamic?> jsonMap) {
    return Product(
        id: jsonMap['id'] as int,
        title: jsonMap['product_name'],
        storeName: jsonMap['store_name'],
        storeId: jsonMap['store_no'],
        imageUrl: jsonMap['product_image'],
        myRate:  double.tryParse(jsonMap['myRate'].toString())== 0.0
            ? null
            : (jsonMap['myRate'] as double),
        description: jsonMap['description'] ?? '',
        price: jsonMap['product_price'] as double,
        sale: jsonMap['offer'] as double?,
        rate: jsonMap['rate'] as double);
  }

  Product copyWith({
    int? id,
    String? title,
    String? storeName,
    String? storeId,
    String? imageUrl,
    double? price,
    double? sale,
    double? rate,
    double? myRate,
    String? description,
  }) {
    return Product(
        id: id ?? this.id,
        title: title ?? this.title,
        storeName: storeName ?? this.storeName,
        storeId: storeId ?? this.storeId,
        imageUrl: imageUrl ?? this.imageUrl,
        description: description ?? this.description,
        price: price ?? this.price,
        sale: sale ?? this.sale,
        myRate: myRate ?? this.myRate,
        rate: rate ?? this.rate);
  }

  Map<String, dynamic?> toMap() => {
        "id": id,
        "product_name": title,
        "store_name": storeName,
        "store_no": storeId,
        "product_image": imageUrl,
        "description": description,
        "product_price": price,
        "offer": sale,
        "rate": rate,
        "myRate": myRate
      };
}
