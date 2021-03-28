


import 'package:mobox/utils/shared_initializer.dart';

abstract class LocalAuth {
  String? getUserToken();

  void storeTheToken(String token);
}

class LocalAuthImpl extends LocalAuth {
  final SharedInitializer sharedInitializer;

  LocalAuthImpl({required this.sharedInitializer});

  @override
  void storeTheToken(String token) {
    sharedInitializer.sharedPreferences.setString('id', token);
  }

  @override
  String? getUserToken() {
    return sharedInitializer.sharedPreferences.getString('id');
  }
}
