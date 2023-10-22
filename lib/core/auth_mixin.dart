import 'package:google_sign_in/google_sign_in.dart';

mixin AuthenticationMixin {
  Future<AuthenticationResult> googleAuthentication() async {
    GoogleSignInAccount? result;
    result = await getGoogleSignIn().signIn();

    //await _clearStorage();
    final auth = await result?.authentication;

    String userName = getUserName(result) ?? "";
    return AuthenticationResult(
      authToken: auth?.accessToken,
      authId: auth?.idToken,
      userName: userName,
      email: result?.email,
    );
  }
}

GoogleSignIn getGoogleSignIn() {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      "profile",
    ],
  );

  return _googleSignIn;
}

String? getUserName(GoogleSignInAccount? result) {
  return result != null && isStringValid(result.email)
      ? result.email.substring(0, result.email.indexOf("@"))
      : result != null && isStringValid(result.displayName)
          ? result.displayName
          : "";
}

bool isStringValid(String? s) {
  return s != null && s.trim().isNotEmpty && s.length > 0;
}

class AuthenticationResult {
  AuthenticationResult({
    this.authToken,
    this.userName,
    this.authId,
    this.email,
    this.error,
  });
  String? authToken;
  String? authId;
  String? email;
  String? userName;
  String? error;
}
