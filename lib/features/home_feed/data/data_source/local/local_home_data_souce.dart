import 'package:mobox/core/model/product_model.dart';

abstract class LocalHomeDataSource {
  List<Product>? getAdList();

  List<Product>? getOfferList();

  List<Product>? getNewProductList();

  void setAdList(List<Product> adList);

  void setOfferList(List<Product> offerList);

  void setNewProductList(List<Product> newProductList);
}

class LocalHomeDataSourceImpl extends LocalHomeDataSource {
  List<Product>? adList;
  List<Product>? offerList;
  List<Product>? newProductList;

  @override
  List<Product>? getAdList() => adList;

  @override
  List<Product>? getNewProductList() => newProductList;

  @override
  List<Product>? getOfferList() => offerList;

  @override
  void setAdList(List<Product> adList) => this.adList = adList;

  @override
  void setNewProductList(List<Product> newProductList) =>
      this.newProductList = newProductList;

  @override
  void setOfferList(List<Product> offerList) => this.offerList = offerList;
}
