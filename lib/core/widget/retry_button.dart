import 'package:flutter/material.dart';

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
