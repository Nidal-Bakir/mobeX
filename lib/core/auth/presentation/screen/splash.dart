import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobox/core/auth/bloc/auth/auth_bloc.dart';
import 'package:mobox/core/utils/shared_initializer.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    GetIt.instance.isReady<SharedInitializer>().then((_) {
      // register SharedPreferences var in get_it
      GetIt.instance.registerSingleton<SharedPreferences>(
          GetIt.I.get<SharedInitializer>().sharedPreferences);
      // kickoff the auth process
      context.read<AuthBloc>().add(AuthUserProfileLoaded());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            SizedBox(height: 64),
            CircularProgressIndicator(),
          ],
        ),
        listener: (context, state) {
          if (state is AuthLoadUserProfileSuccess) {
            Navigator.of(context).pushReplacementNamed('/home');
          } else if (state is AuthLoadUserProfileNotAuthenticated) {
            Navigator.of(context).pushReplacementNamed('/login');
          }
        },
      ),
    );
  }
}
