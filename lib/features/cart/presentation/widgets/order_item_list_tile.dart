import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/features/cart/presentation/bloc/cart_bloc.dart';

class OrderItemListTile extends StatelessWidget {
  final Product product;
  final int quantity;

  const OrderItemListTile(
      {Key? key, required this.product, required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ],
        ),
        color: Colors.red,
      ),
      onDismissed: (direction) =>
          context.read<CartBloc>().add(CartProductDeleted(product)),
      key: Key(product.id.toString()),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 18.0),
        leading: Image.asset(
          product.imageUrl,
          width: 80,
          fit: BoxFit.cover,
        ),
        title: Text(
          product.title,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => context.read<CartBloc>().add(
                        CartQuantityEdited(product, quantity + 1),
                      ),
                ),
                Text('x$quantity'),
                IconButton(
                  alignment: Alignment.topCenter,
                  icon: Icon(Icons.minimize),
                  onPressed: quantity == 1
                      ? null
                      : () => context.read<CartBloc>().add(
                            CartQuantityEdited(product, quantity - 1),
                          ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
