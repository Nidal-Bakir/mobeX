import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobox/core/auth/presentation/screen/login.dart';
import 'package:mobox/core/auth/presentation/screen/splash.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/core/model/user_profiel.dart';
import 'package:mobox/core/screen/app_screen.dart';
import 'package:mobox/core/screen/store_screen.dart';
import 'package:mobox/features/create_store/presentation/pages/create_store_screen.dart';
import 'package:mobox/features/product_management/presentation/screen/product_management.dart';
import 'package:mobox/features/profile/presentation/screen/edit_profile.dart';
import 'package:mobox/features/search/presentation/screen/search.dart';
import 'package:mobox/features/search/util/search_value_state_provider.dart';
import 'package:mobox/features/suspend/presentation/screen/suspend.dart';
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

    case '/store-screen':
      var args = (settings.arguments as List);
      return MaterialPageRoute(
        builder: (context) => StoreScreen(
          store: args[0],
          ownerUserName: args[1],
        ),
      );

    case '/product-manage':
      var args = settings.arguments;
      return MaterialPageRoute<bool>(
        builder: (context) => ProductManagement(
          product: args == null ? null : args as Product,
        ),
      );

    case '/edit-profile':
      var args = settings.arguments as UserProfile;
      return MaterialPageRoute(
        builder: (context) => EditProfile(
          userProfile: args,
        ),
      );

    case '/create-store':
      return MaterialPageRoute(
        builder: (context) => CreateStoreScreen(),
      );

    case '/suspend':
      return MaterialPageRoute(
        builder: (context) => Suspend(),
      );

    // /product_screen Navigated through the Navigator.push(MaterialPageRoute)
    // in the product cart widget to push the corresponding ProductBloc to the screen.
    //
    // And the same applied to moreProducts screen, in the products_list widget.

  }
  assert(false, 'Need to implement ${settings.name}');
  return null;
}
