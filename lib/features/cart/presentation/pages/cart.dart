import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/auth/bloc/auth/auth_bloc.dart';
import 'package:mobox/core/utils/global_function.dart';
import 'package:mobox/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:mobox/features/cart/presentation/widgets/cart_widget.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var auth = context.read<AuthBloc>();
    var profile = (auth.state as AuthLoadUserProfileSuccess).userProfile;
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping cart'),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listenWhen: (previous, current) {
          return current is CartInProgress ||
              current is CartCheckOutFailure ||
              current is CartCheckOutInsufficientBalanceFailure ||
              (previous is CartInProgress && current is CartCheckOutSuccess);
        },
        listener: (context, state) {
          if (state is CartInProgress) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Loading...'), CircularProgressIndicator()],
                  ),
                ),
              ),
            );
          } else if (state is CartCheckOutFailure) {
            showSnack(context,
                'we can not place your order please check your internet connection ');
          } else if (state is CartCheckOutInsufficientBalanceFailure) {
            auth.add(AuthUpdateUserProfileLoaded());
            showSnack(context, 'You do not have enough money!!');
          } else if (state is CartCheckOutSuccess) {
            // pop the loading dialog
            Navigator.of(context).pop();
          }
        },
        buildWhen: (previous, current) {
          return current is CartCheckOutSuccess ||
              current is CartEditQuantitySuccess ||
              current is CartAddItemSuccess ||
              current is CartDeletedItemSuccess ||
              current is CartEmpty;
        },
        builder: (BuildContext context, state) {
          if (state is CartEditQuantitySuccess ||
              state is CartDeletedItemSuccess ||
              state is CartAddItemSuccess) {
            return CartWidget(
              state: state,
              profile: profile,
            );
          } else if (state is CartCheckOutSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/delivery.png',),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('Your order has been placed'),
                )
              ],
            );
          }
          return Center(
            child: Image.asset('assets/images/empty_cart.png'),
          );
        },
      ),
    );
  }
}

