import 'package:mobox/core/model/product_model.dart';

abstract class LocalProductDataSource {
  /// returns stream from new list it's data from the source Map
  /// to solve the error case where the list is read/write from it in concurrent
  /// time
  Stream<Product> getProductsStreamFromLocalEndPoint(String endPoint);

  void appendCache(Future<List<Product>> productList, String endPoint);

  int getNumberOfCachedProductsForEndPoint(String endPoint);

  void upDateProduct(String endPoint, Product product);

  void addProduct(String endPoint, Product product);

  void deleteProduct(String endPoint, Product product);
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
    if (productIndex == -1) return;
    productList.removeAt(productIndex);
    productList.insert(productIndex, upDateProduct);
    // update the cache
    cache[endPoint]=productList;
  }

  @override
  void addProduct(String endPoint, Product product) {
    // get product list
    var productList = cache[endPoint];
    if (productList == null) return;
    productList.insert(0, product);
    // update the cache
    cache[endPoint]=productList;
  }

  @override
  void deleteProduct(String endPoint, Product product) {
    // get product list
    var productList = cache[endPoint];
    if (productList == null) return;
    productList.remove(product);
    // update the cache
    cache[endPoint]=productList;
  }
}
