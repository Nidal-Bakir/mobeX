import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobox/core/screen/app_screen.dart';
import 'package:mobox/core/auth/presentation/screen/login.dart';
import 'package:mobox/core/auth/presentation/screen/splash.dart';
import 'package:mobox/features/search/presentation/screen/search.dart';
import 'package:mobox/features/search/util/search_value_state_provider.dart';
import 'package:provider/provider.dart';

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
    case '/search':
      return MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => SearchValueStateProvider(),
          child: Search(),
        ),
      );

    // /product_screen Navigated through the Navigator.push(MaterialPageRoute)
    // in the product cart widget to push the corresponding ProductBloc to the screen.
    //
    // And the same applied to moreProducts screen, in the products_list widget.

  }
  assert(false, 'Need to implement ${settings.name}');
  return null;
}
