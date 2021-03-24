import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/business_logic/auth/auth_bloc.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            BlocListener<AuthBloc, AuthState>(
              child: Column(
                children: [
                  Image.asset('assets/images/logo.png'),
                  SizedBox(height: 20),
                  CircularProgressIndicator(),
                ],
              ),
              listener: (context, state) {
                if (state is AuthLoadTokenSuccess) {
                  Navigator.of(context).pushReplacementNamed('/home');
                } else if (state is AuthLoadTokenNotAuthenticated) {
                  Navigator.of(context).pushReplacementNamed('/login');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
