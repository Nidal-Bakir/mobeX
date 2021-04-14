import 'package:mobox/core/model/product_model.dart';

abstract class LocalProductDataSource {
  Stream<Product> getProductsStreamFromLocalEndPoint(String endPoint);

  void appendCache(Future<List<Product>> productList, String endPoint);

  int getNumberOfCachedProductsForEndPoint(String endPoint);
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
}
