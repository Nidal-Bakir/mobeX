import 'package:flutter/material.dart';
import 'package:mobox/core/bloc/product_bloc/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RetryTextButton extends StatelessWidget {
  final void Function() onClickCallback ;

  const RetryTextButton({Key? key,required this.onClickCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClickCallback ,
      child: Text('RETRY'),
      style: Theme.of(context).textButtonTheme.style,
    );
  }
}
