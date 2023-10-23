import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkedin_login/linkedin_login.dart';

import '../core.dart';

enum AccountType { google, facebook, linkedin }

//Beer Barrel User Authentication Repository
class AuthRepository {
  final GoogleSignIn googleSignIn;

  AuthRepository(this.googleSignIn);

  // Future<User> loginWithSocialMedia(AccountType loginWith) async {
  //   switch (loginWith) {
  //     case AccountType.google:
  //       return await handleGoogleSignin();
  //     case AccountType.facebook:
  //       ;
  //     case AccountType.linkedin:
  //       ;
  //   }
  // }

  Future<User?> loginWithSocialMedia(AccountType loginWith,
      {LinkedInUserModel? linkedinUser}) async {
    switch (loginWith) {
      case AccountType.google:
        return await handleGoogleSignIn();
      case AccountType.facebook:
        ;
      case AccountType.linkedin:
        return await handleLinkedInSignIn(linkedinUser);
    }
  }

  LogoutWith(AccountType logoutWith) async {
    switch (logoutWith) {
      case AccountType.google:
        return await handleGoogleLogout();
      case AccountType.facebook:
        return;
      case AccountType.linkedin:
        return;
    }
  }

  Future<User?> handleGoogleSignIn() async {
    try {
      GoogleSignInAccount? result = await googleSignIn.signIn();
      return User(
        email: result?.email,
        name: result?.displayName,
        photoUrl: result?.photoUrl,
      );
    } catch (e) {
      return null;
    }
  }

  Future<User?> handleLinkedInSignIn(LinkedInUserModel? linkedinUser) async {
    try {
      return User(
        email: linkedinUser?.email?.elements?.first.handleDeep?.emailAddress,
        name:
            "${linkedinUser?.firstName?.localized?.label} ${linkedinUser?.lastName?.localized?.label}",
        photoUrl: linkedinUser?.profilePicture?.displayImageContent?.elements
            ?.elementAt(0)
            .identifiers
            ?.elementAt(0)
            .identifier,
      );
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
