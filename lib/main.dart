import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobox/business_logic/auth/auth_bloc.dart';
import 'package:mobox/presentation/route/app_router.dart';
import 'package:mobox/presentation/theme/theme.dart';
import 'injaction_container.dart' as di;

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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => di.sl(),
      child: MaterialApp(
        onGenerateRoute: onGenerateRoute,
        title: 'Flutter Demo',
        theme: appTheme(),
      ),
    );
  }
}
