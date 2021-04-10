import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  final void Function() onRetry;

  ErrorCard(this.onRetry);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 200,
      child: Card(
        elevation: 0.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/error-cloud.png'),
            TextButton(
              onPressed: onRetry,
              child: Text('RETRY'),
              style: Theme.of(context).textButtonTheme.style,
            )
          ],
        ),
      ),
    );
  }
}
