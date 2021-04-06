
import 'package:mobox/core/auth/data/data_source/local/local_auth.dart';
import 'package:mobox/core/auth/data/data_source/remote/remote_auth.dart';

class AuthRepo {
  final LocalAuth localAuth;
  final RemoteAuth remoteAuth;

  AuthRepo({required this.localAuth, required this.remoteAuth});

  String? getUserToken() {
    return localAuth.getUserToken();
  }

  Future<String> login(
      {required String userName, required String password}) async {
    var token = await remoteAuth.login(userName: userName, password: password);
    localAuth.storeTheToken(token);
    return token;
  }
}
