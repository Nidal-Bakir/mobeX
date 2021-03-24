class CannotLoginException implements Exception {
  final String message;

  CannotLoginException(this.message);
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException(this.message);
}
