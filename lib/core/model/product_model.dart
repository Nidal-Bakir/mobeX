import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final String storeName;
  final String imageUrl;
  final double price;
  final double? sale;
  final double rate;

  Product(
      {required this.id,
      required this.title,
      required this.storeName,
      required this.imageUrl,
      required this.price,
      required this.sale,
      required this.rate});

  @override
  List<Object?> get props =>
      [title, storeName, imageUrl, price, sale, rate, id];

  factory Product.fromMap(Map<String, dynamic?> jsonMap) {
    return Product(
        id: jsonMap['id'] as int,
        title: jsonMap['title'],
        storeName: jsonMap['storeName'],
        imageUrl: jsonMap['imageUrl'],
        price: jsonMap['price'] as double,
        sale: jsonMap['sale'] as double?,
        rate: jsonMap['rate'] as double);
  }

  Map<String, dynamic?> toMap() => {
        "id": id,
        "title": title,
        "storeName": storeName,
        "imageUrl": imageUrl,
        "price": price,
        "sale": sale,
        "rate": rate,
      };
}
