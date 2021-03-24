import 'package:mobox/data/data_provider/auth.dart';

class AuthRepo {
  final Auth _auth;

  AuthRepo({required Auth auth}) : _auth = auth;

  Future<String?> getUserToken() {
    return _auth.getUserToken();
  }

  Future<String> login({required String userName, required String password}) async{
    return await _auth.login(userName: userName, password: password);
  }
}
