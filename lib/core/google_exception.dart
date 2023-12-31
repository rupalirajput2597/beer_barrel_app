class LoginWithGoogleFailure implements Exception {
  const LoginWithGoogleFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory LoginWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LoginWithGoogleFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LoginWithGoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LoginWithGoogleFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const LoginWithGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LoginWithGoogleFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LoginWithGoogleFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LoginWithGoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LoginWithGoogleFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const LoginWithGoogleFailure();
    }
  }
  final String message;
}
