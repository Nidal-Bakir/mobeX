import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/business_logic/auth/auth_bloc.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<AuthBloc>().add(AuthTokenLoaded());
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
          if (state is AuthLoadTokenSuccess) {
            // TODO: uncomment the code
            // Navigator.of(context).pushReplacementNamed('/home');
          } else if (state is AuthLoadTokenNotAuthenticated) {
            Navigator.of(context).pushReplacementNamed('/login');
          }
        },
      ),
    );
  }
}
