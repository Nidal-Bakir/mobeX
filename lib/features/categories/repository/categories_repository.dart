import 'package:mobox/core/error/exception.dart';
import 'package:mobox/features/categories/data/local/local_categories_data_source.dart';
import 'package:mobox/features/categories/data/remote/romote_categories_data_source.dart';

class CategoriesRepository {
  final RemoteCategories _remote;
  final LocalCategories _local;

  CategoriesRepository({
    required RemoteCategories remote,
    required LocalCategories local,
  })   : _local = local,
        _remote = remote;

  Future<List<String>> getCategoriesList() async {

    try {
     return await _remote.getCategoriesListFromApi();
    } on ConnectionException catch (_) {
      throw ConnectionExceptionWithData(await _local.getCachedCategoriesList());
    }
  }
}
