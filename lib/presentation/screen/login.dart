import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/business_logic/auth/auth_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static const _url = 'http://flutter.dev';
  late final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer()
    ..onTap = () async {
      ///context.read<AuthBloc>().add(AuthAccountCreated());
      if (await canLaunch(_url)) {
        await launch(_url);
      }
    };

  @override
  void dispose() {
    super.dispose();
    _tapGestureRecognizer.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
            ),
            Image.asset('assets/images/logo.png'),
            SizedBox(
              height: 24,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(hintText: 'username'),
                    validator: (value) {
                      value = value ?? '';
                      if (value.isEmpty) {
                        return 'please enter a username';
                      }
                    },
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    validator: (value) {
                      value = value ?? '';
                      if (value.isEmpty) {
                        return 'please enter a password';
                      } else if (value.length < 6)
                        return 'password must be more than 6 character';
                    },
                    decoration: InputDecoration(hintText: 'username'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Text.rich(
              TextSpan(
                text: "Don't have one? ",
                children: <InlineSpan>[
                  TextSpan(
                    text: 'see how to create account.',
                    recognizer: _tapGestureRecognizer,
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(' LOGIN '),
              ),
            )
          ],
        ),
      ),
    );
  }
}
