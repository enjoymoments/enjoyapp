/// Thrown during the sign in with google process if a failure occurs.
class LogInWithGoogleFailure implements Exception {
  final dynamic exception;

  LogInWithGoogleFailure(this.exception);
}

class LogInWithFacebookFailure implements Exception {
  final dynamic exception;

  LogInWithFacebookFailure(this.exception);
}

class LogInWithAppleFailure implements Exception {
  final dynamic exception;

  LogInWithAppleFailure(this.exception);
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// Thrown during the get token process if a failure occurs.
class GetToken implements Exception {}

