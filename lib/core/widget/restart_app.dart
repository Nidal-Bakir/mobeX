import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobox/injection/injection_container.dart' as di;

class RestartApp extends StatefulWidget {
  final Widget child;

  const RestartApp({Key? key, required this.child}) : super(key: key);

  static void restart(BuildContext context) {
    context.findRootAncestorStateOfType<_RestartAppState>()!._restart();
  }

  @override
  _RestartAppState createState() => _RestartAppState();
}

class _RestartAppState extends State<RestartApp> {
  var _key = UniqueKey();

  void _restart() async{
    await GetIt.I.reset();
    di.init();
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: widget.child,
    );
  }
}
