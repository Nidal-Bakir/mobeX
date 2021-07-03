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

class BadReturnedData implements Exception {
  final Object data;

  const BadReturnedData(this.data);
}

class InsufficientBalance implements Exception {
  final String message;

  const InsufficientBalance(this.message);
}

class UnHandledStateException implements Exception {
  final dynamic state;

  const UnHandledStateException(this.state);

  @override
  String toString() => state.toString();
}
