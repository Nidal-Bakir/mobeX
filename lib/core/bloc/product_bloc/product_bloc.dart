import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/core/repository/product_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(this.productRepository, this.endPoint)
      : super(ProductInProgress());
  final ProductRepository productRepository;
  final String endPoint;

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is ProductDataLoaded) {
      yield* _dataLoadedHandler();
    } else if (event is ProductReRequested) {
      yield* _adRequestedHandler();
    }
  }

  Stream<ProductState> _dataLoadedHandler() async* {
    yield* _loadData();
  }

  Stream<ProductState> _adRequestedHandler() async* {
    yield ProductInProgress();
    yield* _loadData();
  }

  Stream<ProductState> _loadData() async* {
    var adStream = productRepository.getProductsStreamFromEndPoint(endPoint);

    yield* adStream
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
}
