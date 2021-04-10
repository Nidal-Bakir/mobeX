import 'package:mobox/core/model/product_model.dart';

abstract class LocalProductDataSource {
  Stream<Product> getProductsStreamFromLocalEndPoint(String endPoint);

  void appendCache(Future<List<Product>> adList, String endPoint);
}

class LocalProductDataSourceImpl extends LocalProductDataSource {
  final Map<String, List<Product>> cache = {};

  @override
  void appendCache(Future<List<Product>> adList, String endPoint) async {
    var _adList = await adList;
    this.cache.update(
          endPoint,
          (value) => [...value]..addAll(_adList),
          ifAbsent: () => _adList,
        );
  }

  /// returns stream from new list it's data from the source Map
  /// to solve the error case where the list is read/write from it in concurrent
  /// time
  @override
  Stream<Product> getProductsStreamFromLocalEndPoint(String endPoint) =>
      Stream.fromIterable([...cache[endPoint] ?? []]);
}
