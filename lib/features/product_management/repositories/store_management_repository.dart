import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/features/product_management/data/model/editable_product_info.dart';
import 'package:mobox/features/product_management/data/remote/data_sources/store_management_remote_data_source.dart';

class ProductManagementRepository{
  final ProductManagementRemoteDataSource _remote;

  ProductManagementRepository({required ProductManagementRemoteDataSource storeManagementRemoteDataSource})
      : _remote = storeManagementRemoteDataSource;

  Future<Product> addNewProduct(EditableProductInfo newProduct) async =>
      _remote.addNewProduct(newProduct);

  Future<Product> editExistingProduct(
      Product product, EditableProductInfo newProductInfo) async =>
      _remote.editExistingProduct(product, newProductInfo);

  Future<bool> deleteProduct(Product product) async =>
      _remote.deleteProduct(product);

}
