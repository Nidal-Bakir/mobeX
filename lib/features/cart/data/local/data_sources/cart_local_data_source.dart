import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/features/cart/data/models/check_out_order.dart';
import 'package:mobox/features/cart/data/models/checkout_order_item.dart';

abstract class CartLocalDataSource {
  final CheckOutOrder checkOutOrder;

  CartLocalDataSource(this.checkOutOrder);

  void addProduct(Product product);

  void deleteOrder();

  void editQuantity(Product product, int newQuantity);

  void deleteProduct(Product product);

  CheckOutOrder getCheckOutOrder();
}

class CartLocalDataSourceImpl extends CartLocalDataSource {
  CartLocalDataSourceImpl() : super(CheckOutOrder.empty());

  void deleteOrder() {
    checkOutOrder.items.clear();
  }

  void addProduct(Product product) {
    var index = checkOutOrder.items
        .indexWhere((element) => element.product.id == product.id);
    if (index == -1) {
      checkOutOrder.items.add(CheckOutOrderItem(product, 1));
    } else {
      var item = checkOutOrder.items.removeAt(index);
      item = item.copyWith(quantity: item.quantity + 1);
      checkOutOrder.items.insert(index, item);
    }
  }

  void editQuantity(Product product, int newQuantity) {
    var index = checkOutOrder.items
        .indexWhere((element) => element.product.id == product.id);
    if (index == -1) {
      checkOutOrder.items.add(CheckOutOrderItem(product, 1));
    } else {
      var item =
          checkOutOrder.items.removeAt(index).copyWith(quantity: newQuantity);

      checkOutOrder.items.insert(index, item);
    }
  }

  void deleteProduct(Product product) {
    var index = checkOutOrder.items
        .indexWhere((element) => element.product.id == product.id);
    if (index == -1) {
      return;
    } else {
      checkOutOrder.items.removeAt(index);
    }
  }

  @override
  CheckOutOrder getCheckOutOrder() => checkOutOrder.copyWith();
}
