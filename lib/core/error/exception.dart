class CannotLoginException implements Exception {
  final String message;

  const CannotLoginException(this.message);
}

class AuthenticationException implements Exception {
  final String message;

  const AuthenticationException(this.message);
}

class ConnectionException implements Exception {
  final String message;

  const ConnectionException(this.message);
}

class ConnectionExceptionWithData implements Exception {
  final Object? data;

  const ConnectionExceptionWithData(this.data);
}
