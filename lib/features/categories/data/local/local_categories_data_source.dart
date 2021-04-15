abstract class LocalCategories {
  Future<List<String>> getCachedCategoriesList();

  void setCachedCategoriesList(List<String> categoriesList);
}

class LocalCategoriesImpl extends LocalCategories {
  List<String> _cachedCategoriesList = [];

  @override
  Future<List<String>> getCachedCategoriesList() async => _cachedCategoriesList;

  @override
  void setCachedCategoriesList(List<String> categoriesList) {
    _cachedCategoriesList = categoriesList;
  }
}
