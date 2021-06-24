import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mobox/core/model/user_profiel.dart';
import 'package:mobox/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:mobox/features/cart/presentation/widgets/order_item_list_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartWidget extends StatelessWidget {
  final state;
  final UserProfile profile;
  late final checkOutOrder = state.checkOutOrder;
  late final totalPrice = state.totalComputation.totalPrice;
  late final totalQuantity = state.totalComputation.totalQuantity;

  CartWidget({Key? key, required this.state, required this.profile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Flexible(
          flex: 1,
          child: ListView.separated(
            padding: EdgeInsets.only(top: 8.0),
            itemBuilder: (context, index) => OrderItemListTile(
              product: checkOutOrder.items[index].product,
              quantity: checkOutOrder.items[index].quantity,
            ),
            itemCount: checkOutOrder.items.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
          ),
        ),
        Flexible(
          flex: 0,
          child: Table(
            defaultColumnWidth: IntrinsicColumnWidth(),
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 8.0),
                    child: Text('Total quantity: $totalQuantity',
                        textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 8.0),
                    child: Text(
                      'Total price: $totalPrice',
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              TableRow(children: [
                TextButton(
                  style: Theme.of(context).textButtonTheme.style?.copyWith(
                        foregroundColor: MaterialStateProperty.all(Colors.grey),
                      ),
                  onPressed: () {
                    context.read<CartBloc>().add(CartAllItemsDeleted());
                  },
                  child: Text('Delete the Order'),
                ),
                TextButton(
                  onPressed: profile.balance < totalPrice
                      ? null
                      : () {
                          context.read<CartBloc>().add(CartCheckOutRequested());
                        },
                  child: Text('CheckOut '),
                )
              ]),
            ],
          ),
        ),
        // if (profile.balance < totalPrice) Text('Insufficient balance'),
      ],
    );
  }
}
