import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/auth/bloc/auth/auth_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _obscureText = true;
  final formKey = GlobalKey<FormState>();
  String? userName, password;
  late final TapGestureRecognizer _tapGestureRecognizer =
      TapGestureRecognizer();

  @override
  void dispose() {
    super.dispose();
    _tapGestureRecognizer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 32,
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
                      decoration: InputDecoration(
                        labelText: 'username',
                      ),
                      style: TextStyle(color: Colors.black),
                      onSaved: (newValue) => userName = newValue,
                      validator: (value) {
                        value = value ?? '';
                        if (value.trim().isEmpty) {
                          return 'please enter a username';
                        }
                      },
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      obscureText: _obscureText,
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        value = value ?? '';
                        if (value.trim().isEmpty) {
                          return 'please enter a password';
                        } else if (value.length < 6)
                          return 'password must be more than 6 character length';
                      },
                      onSaved: (newValue) => password = newValue,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.visibility_rounded,
                              color: Colors.blueGrey,
                            ),
                            onPressed: () => setState(() {
                              _obscureText = !_obscureText;
                            }),
                          ),
                          labelText: 'password'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              BlocListener<AuthBloc, AuthState>(
                listenWhen: (previous, current) => current is AuthCreateAccount,
                listener: (BuildContext context, state) async {
                  // TODO : use our url
                  if (await canLaunch('http://mobox.com')) {
                    await launch('http://mobox.com');
                  }
                },
                child: Text.rich(
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
              ),
              SizedBox(
                height: 32,
              ),
              BlocConsumer<AuthBloc, AuthState>(
                builder: (BuildContext context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      state is AuthLoadUserProfileInProgress
                          ? CircularProgressIndicator()
                          : Container(),
                      ElevatedButton(
                        onPressed: state is! AuthLoadUserProfileInProgress
                            ? () {
                                if (formKey.currentState?.validate() ?? false) {
                                  formKey.currentState?.save();
                                  context.read<AuthBloc>().add(
                                        AuthLoginRequested(
                                          userName: '$userName',
                                          password: '$password',
                                        ),
                                      );
                                }
                              }
                            : null,
                        child: Text(
                          'LOGIN',
                        ),
                      ),
                    ],
                  );
                },
                listener: (BuildContext context, Object? state) {
                  if (state is AuthLoadUserProfileFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${state.message}')));
                  } else if (state is AuthLoadUserProfileSuccess) {
                    Navigator.of(context).pushReplacementNamed('/home');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
