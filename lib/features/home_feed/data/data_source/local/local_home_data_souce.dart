import 'package:mobox/core/model/product_model.dart';

abstract class LocalHomeDataSource {
  List<Product> getAdList();

  List<Product> getOfferList();

  List<Product> getNewProductList();

  void appendAdList(List<Product> adList);

  void appendOfferList(List<Product> offerList);

  void appendNewProductList(List<Product> newProductList);
}

class LocalHomeDataSourceImpl extends LocalHomeDataSource {
  List<Product> adList = [];
  List<Product> offerList = [];
  List<Product> newProductList = [];

  @override
  List<Product> getAdList() => adList;

  @override
  List<Product> getNewProductList() => newProductList;

  @override
  List<Product> getOfferList() => offerList;

  @override
  void appendAdList(List<Product> adList) => this.adList.addAll(adList);

  @override
  void appendNewProductList(List<Product> newProductList) =>
      this.newProductList.addAll(newProductList);

  @override
  void appendOfferList(List<Product> offerList) =>
      this.offerList.addAll(offerList);
}
