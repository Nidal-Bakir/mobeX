import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Image.asset('assets/images/logo.png'),
        SizedBox(height: 20),
      ],
    ));
  }
}
