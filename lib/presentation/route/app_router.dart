import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobox/presentation/screen/login.dart';
import 'package:mobox/presentation/screen/splash.dart';

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
  }
}
