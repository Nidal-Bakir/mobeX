import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/core/screen/app_screen.dart';
import 'package:mobox/core/auth/presentation/screen/login.dart';
import 'package:mobox/core/auth/presentation/screen/splash.dart';
import 'package:mobox/core/screen/product_screen.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (context) => Splash(),
      );
    case '/login':
      return MaterialPageRoute(
        builder: (context) => Login(),
      );
    case '/home':
      return MaterialPageRoute(
        builder: (context) => AppScreen(),
      );
    case '/product':
      return MaterialPageRoute(
        builder: (context) => ProductScreen(
          product: settings.arguments as Product,
        ),
      );
  }
  assert(false, 'Need to implement ${settings.name}');
  return null;
}
