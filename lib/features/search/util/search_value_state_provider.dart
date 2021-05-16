import 'package:flutter/foundation.dart';

enum SearchType { Products, Stores }

class SearchValueStateProvider extends ChangeNotifier {
  SearchType _searchType = SearchType.Products;
  String _searchTerms = '';
  double? _priceLessThenOrEqual;

  SearchType getSearchType() => _searchType;

  String getSearchTerms() => _searchTerms;

  double? getPriceLessThenOrEqual() => _priceLessThenOrEqual;

  void setSearchType(SearchType searchType) {
    _searchType = searchType;
    notifyListeners();
  }

  void setSearchTerms(String searchTerms) => _searchTerms = searchTerms.trim();

  void setPriceLessThenOrEqual(double? priceLessThenOrEqual) =>
      _priceLessThenOrEqual = priceLessThenOrEqual;
}
