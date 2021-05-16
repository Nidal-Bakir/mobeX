import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobox/core/error/exception.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/core/repository/product_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  final String endPoint;

  ProductBloc(this.productRepository, this.endPoint)
      : super(endPoint == 'search'
            ? ProductSearchInitial()
            : ProductInProgress());

  @override
  Stream<Transition<ProductEvent, ProductState>> transformEvents(
      Stream<ProductEvent> events, transitionFn) {
    return super.transformEvents(events.debounce((event) {
      if (event is ProductsSearchLoaded ||
          event is ProductMoreSearchDataLoaded) {
        return Stream.value(event).debounceTime(Duration(milliseconds: 300));
      } else if (event is ProductMoreDataLoaded) {
        return Stream.value(event).debounceTime(Duration(milliseconds: 150));
      }
      return Stream.value(events);
    }), transitionFn);
  }

  List<Product> getCurrentProductListFromCurrentState() {
    var currentState = state;
    List<Product> _productList = [];
    if (currentState is ProductLoadSuccess ||
        currentState is ProductMoreInProgress) {
      // this is necessary because dart cast the currentState if check for two subclasses to it's there father
      // in this case the ProductState and it doesn't have productList member
      if (currentState is ProductLoadSuccess) {
        _productList = currentState.productList;
      } else if (currentState is ProductMoreInProgress) {
        _productList = currentState.productList;
      }
    }
    return _productList;
  }

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is ProductDataLoaded) {
      yield* _productDataLoadedHandler();
    } else if (event is ProductLoadRetried) {
      yield* _productLoadRetriedHandler();
    } else if (event is ProductMoreDataLoaded) {
      yield* _productMoreDataLoadedHandler();
    } else if (event is ProductRateUpDated) {
      yield* _productRateUpDatedHandler(
        product: event.product,
        newRate: event.newRate,
        oldRate: event.oldRate,
      );
    } else if (event is ProductsSearchLoaded) {
      yield* _productSearchHandler(
          event.productName, event.priceLessThenOrEqual);
    } else if (event is ProductSearchLoadRetried) {
      yield* _productSearchHandler(
          event.productName, event.priceLessThenOrEqual);
    } else if (event is ProductMoreSearchDataLoaded) {
      yield* _productSearchHandler(
          event.productName, event.priceLessThenOrEqual);
    } else if (event is ProductSearchInitialed) {
      yield ProductSearchInitial();
    }
  }

  Stream<ProductState> _productMoreDataLoadedHandler() async* {
    var _productList = getCurrentProductListFromCurrentState();

    yield ProductMoreInProgress(productList: _productList);

    var productStream = productRepository
        .getProductsStreamFromAPIForInfiniteScrolling(endPoint);

    yield* productStream
        .bufferCount(10)
        .scan<List<Product>>(
            (acc, curr, index) => [...acc ?? []]..addAll(curr), _productList)
        .map((event) => ProductLoadSuccess(productList: event))
        .doOnError((_, __) =>
            this.emit(ProductLoadFailure(productList: _productList)));
  }

  Stream<ProductState> _productDataLoadedHandler() async* {
    yield* _loadData();
  }

  Stream<ProductState> _productLoadRetriedHandler() async* {
    yield ProductInProgress();
    yield* _loadData();
  }

  Stream<ProductState> _loadData() async* {
    var productStream =
        productRepository.getProductsStreamFromEndPoint(endPoint);

    yield* productStream
        .bufferCount(5)
        .scan<List<Product>>((acc, curr, index) => [...acc ?? []]..addAll(curr))
        .map((event) => event.isEmpty
            ? ProductNoData()
            : ProductLoadSuccess(productList: event))
        .startWith(ProductNoData())
        .onErrorReturn(ProductLoadFailure(
            productList: await productRepository
                .getProductsStreamFromLocalCache(endPoint)
                .toList()));
  }

  Stream<ProductState> _productRateUpDatedHandler({
    required Product product,
    required double? newRate,
    required double? oldRate,
  }) async* {
    try {
      var map = await productRepository.sendUserRateForProduct(
          oldRate, newRate, product, endPoint);
      yield ProductRateSuccess(map['newRate'], map['newProductRateFromAPI']!);
      // publish the updated data
      yield ProductLoadSuccess(
          productList: await productRepository
              .getProductsStreamFromLocalCache(endPoint)
              .toList());
    } on ConnectionException {
      yield ProductRateFailure();
    }
  }

  Stream<ProductState> _productSearchHandler(
      String productName, double? priceLessThenOrEqual) async* {
    var _productList = getCurrentProductListFromCurrentState();

    yield* productRepository
        .searchProductsByTitle(
            title: productName,
            priceLessThenOrEqual: priceLessThenOrEqual,
            paginationCount: _productList.length)
        .bufferCount(10)
        .scan<List<Product>>(
            (acc, current, index) => [...acc ?? []]..addAll(current),
            _productList)
        .map((event) => event.isEmpty
            ? ProductNoData()
            : ProductLoadSuccess(productList: event))
        .startWith(ProductInProgress())
        .onErrorReturn(ProductLoadFailure(productList: _productList));
  }
}
