import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:mobox/business_logic/auth/auth_bloc.dart';
import 'package:mobox/data/data_provider/auth.dart';
import 'package:mobox/data/repository/auth_repo.dart';
import 'package:mobox/presentation/screen/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthRepo _authRepo = AuthRepo(auth: HttpAuth(Client()));

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => AuthBloc(authRepo: _authRepo),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Splash(),
      ),
    );
  }
}
