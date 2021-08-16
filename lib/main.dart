import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/auth/bloc/auth/auth_bloc.dart';
import 'package:mobox/core/widget/restart_app.dart';
import 'package:mobox/features/order/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:mobox/injection/injection_container.dart' as di;
import 'package:mobox/route/app_router.dart';
import 'package:mobox/theme/theme.dart';

import 'core/bloc/product_management/product_manage_bloc.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.white.withAlpha(100),
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  di.init();
  runApp(
    RestartApp(
      child: BlocProvider<AuthBloc>(
        create: (_) => di.sl(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductManageBloc>(create: (_) => di.sl()),
        BlocProvider<CartBloc>(create: (_) => di.sl()),
        BlocProvider<OrderBloc>(create: (_) => di.sl())
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) => current is AuthAccountSuspend,
        listener: (context, state) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacementNamed('/suspend');
        },
        child: MaterialApp(
          onGenerateRoute: onGenerateRoute,
          title: 'Flutter Demo',
          theme: appTheme(),
        ),
      ),
    );
  }
}
