import 'package:google_sign_in/google_sign_in.dart';

enum AccountType { google, facebook, linkedin }

//Beer Barrel User Authentication Repository
class AuthRepository {
  final GoogleSignIn googleSignIn;

  AuthRepository(this.googleSignIn);

  loginWithSocialMedia(AccountType loginWith) async {
    switch (loginWith) {
      case AccountType.google:
        return await handleGoogleSignin();
      case AccountType.facebook:
        ;
      case AccountType.linkedin:
        ;
    }
  }

  LogoutWith(AccountType logoutWith) async {
    switch (logoutWith) {
      case AccountType.google:
        return await handleGoogleLogout();
      case AccountType.facebook:
        ;
      case AccountType.linkedin:
        ;
    }
  }

  Future<GoogleSignInAccount?> handleGoogleSignin() async {
    try {
      GoogleSignInAccount? result = await googleSignIn.signIn();
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<GoogleSignInAccount?> handleGoogleLogout() async {
    try {
      GoogleSignInAccount? result = await googleSignIn.signOut();
      return result;
    } catch (e) {
      return null;
    }
  }
}
