import 'package:mobox/core/model/product_model.dart';

abstract class LocalProductDataSource {
  Stream<Product> getProductsStreamFromLocalEndPoint(String endPoint);

  void appendCache(Future<List<Product>> productList, String endPoint);

  int getNumberOfCachedProductsForEndPoint(String endPoint);

  void upDateProduct(String endPoint, Product product);
}

class LocalProductDataSourceImpl extends LocalProductDataSource {
  final Map<String, List<Product>> cache = {};

  @override
  void appendCache(Future<List<Product>> productList, String endPoint) async {
    var _productList = await productList;
    this.cache.update(
          endPoint,
          (value) => [...value]..addAll(_productList),
          ifAbsent: () => _productList,
        );
  }

  /// returns stream from new list it's data from the source Map
  /// to solve the error case where the list is read/write from it in concurrent
  /// time
  @override
  Stream<Product> getProductsStreamFromLocalEndPoint(String endPoint) =>
      Stream.fromIterable([...cache[endPoint] ?? []]);

  @override
  int getNumberOfCachedProductsForEndPoint(String endPoint) =>
      cache[endPoint]?.length ?? 0;

  @override
  void upDateProduct(String endPoint, Product upDateProduct) {
    // get product list
    var productList = cache[endPoint];
    if (productList == null) return;
    // get the index of the product to replace it.
    int productIndex =
        productList.indexWhere((element) => element.id == upDateProduct.id);
    productList.removeAt(productIndex);
    productList.insert(productIndex, upDateProduct);
    // update the cache
    cache.update(endPoint, (value) => productList);
  }
}
