

class AuthenticationException implements Exception {
  final String message;

  const AuthenticationException(this.message);
}

class ConnectionException implements Exception {
  final String message;

  const ConnectionException(this.message);
}

class ConnectionExceptionWithData implements Exception {
  final Object data;

  const ConnectionExceptionWithData(this.data);
}
