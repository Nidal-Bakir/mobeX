import 'package:flutter/material.dart';
import 'package:mobox/core/bloc/product_bloc/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RetryTextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.read<ProductBloc>().add(ProductLoadRetried()),
      child: Text('RETRY'),
      style: Theme.of(context).textButtonTheme.style,
    );
  }
}
