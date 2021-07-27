import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:mobox/core/error/exception.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/features/product_management/data/model/editable_product_info.dart';
import 'package:mobox/features/product_management/repositories/store_management_repository.dart';

part 'product_manage_event.dart';

part 'product_manage_state.dart';

class ProductManageBloc extends Bloc<ProductManageEvent, ProductManageState> {
  final ProductManagementRepository _repository;

  ProductManageBloc(this._repository) : super(ProductManageInitial());

  @override
  Stream<ProductManageState> mapEventToState(
    ProductManageEvent event,
  ) async* {
    yield ProductManageInProgress();

    if (event is ProductManageProductAdded) {
      yield* _productManageProductAddedHandler(event.product);
    } else if (event is ProductManageProductEdited) {
      yield* _productManageProductEditedHandler(
          event.product, event.editableProductInfo);
    } else if (event is ProductManageProductDeleted) {
      yield* _productManageProductDeletedHandler(event.product);
    } else if (event is ProductManageResetState) {
      yield ProductManageInitial();
    }
  }

  Stream<ProductManageState> _productManageProductAddedHandler(
      EditableProductInfo newProduct) async* {
    try {
      var returnedProduct = await _repository.addNewProduct(newProduct);
      yield ProductManageAddProductSuccess(returnedProduct);
    } on ConnectionException catch (e) {
      yield ProductManageAddProductFailure();
      print(e.message);
    } on BadReturnedData catch (e) {
      yield ProductManageAddProductFailure();
      print(e.data);
    }
  }

  Stream<ProductManageState> _productManageProductEditedHandler(
      Product originalProductInfo, EditableProductInfo newProductInfo) async* {
    try {
      var returnedProduct = await _repository.editExistingProduct(
          originalProductInfo, newProductInfo);

      yield ProductManageEditProductSuccess(returnedProduct);
    } on ConnectionException catch (e) {
      yield ProductManageEditProductFailure();
      print(e.message);
    } on BadReturnedData catch (e) {
      yield ProductManageEditProductFailure();
      print(e.data);
    }
  }

  Stream<ProductManageState> _productManageProductDeletedHandler(
      Product deletedProduct) async* {
    var isSuccess = await _repository.deleteProduct(deletedProduct);
    if (isSuccess) {
      yield ProductManageDeleteProductSuccess(deletedProduct);
    } else {
      yield ProductManageDeleteProductFailure();
    }
  }
}
