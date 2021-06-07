import 'package:mobox/core/model/product_model.dart';

class EditableProductInfo {
  final String title;
  final String imagePath;
  final double price;
  final String description;
  final double? sale;

  EditableProductInfo({
    this.sale,
    required this.title,
    required this.imagePath,
    required this.price,
    required this.description,
  });

  EditableProductInfo.emptyFields()
      : this.title = '',
        this.description = '',
        price = -1.0,
        imagePath = '',
        sale = -1.0;

  EditableProductInfo.fromProduct(Product product)
      : this.title = product.title,
        this.description = product.description,
        price = product.price,
        imagePath = product.imageUrl,
        sale = product.sale;

  EditableProductInfo copyWith({
    double? sale,
    String? title,
    String? imagePath,
    double? price,
    String? description,
  }) =>
      EditableProductInfo(
          title: title ?? this.title,
          imagePath: imagePath ?? this.imagePath,
          price: price ?? this.price,
          description: description ?? this.description,
          sale: sale);

  bool shareSameDataWithProduct(Product product) {
    return title == product.title &&
        price == product.price &&
        description == product.description &&
        imagePath == product.imageUrl &&
        sale == product.sale;
  }
}
