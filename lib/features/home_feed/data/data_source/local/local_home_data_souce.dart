import 'package:mobox/core/model/product_model.dart';

abstract class LocalHomeDataSource {
  Stream<Product> getAdStream();

  Stream<Product> getOfferStream();

  Stream<Product> getNewProductStream();

  void appendAdList(Future<List<Product>> adList);

  void appendOfferList(Future<List<Product>> offerList);

  void appendNewProductList(Future<List<Product>> newProductList);
}

class LocalHomeDataSourceImpl extends LocalHomeDataSource {
  List<Product> adList = [];
  List<Product> offerList = [];
  List<Product> newProductList = [];

  @override
  Stream<Product> getAdStream() => Stream.fromIterable(adList);

  @override
  Stream<Product> getNewProductStream() => Stream.fromIterable(newProductList);

  @override
  Stream<Product> getOfferStream() => Stream.fromIterable(offerList);

  @override
  void appendAdList(Future<List<Product>> adList) async =>
      this.adList.addAll(await adList);

  @override
  void appendNewProductList(Future<List<Product>> newProductList) async =>
      this.newProductList.addAll(await newProductList);

  @override
  void appendOfferList(Future<List<Product>> offerList) async =>
      this.offerList.addAll(await offerList);
}
