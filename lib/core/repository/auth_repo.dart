import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:logger/logger.dart';

import '../core.dart';

enum AccountType { google, linkedin, facebook }

//Beer Barrel User Authentication Repository
class AuthRepository {
  final GoogleSignIn googleSignIn;
  final FacebookLogin facebookLoginPlugin;
  final FlutterSecureStorage secureStorage;
  AuthRepository(
      this.googleSignIn, this.secureStorage, this.facebookLoginPlugin);

  Future<User?> loginWithSocialMedia(AccountType loginWith,
      {LinkedInUserModel? linkedinUser}) async {
    switch (loginWith) {
      case AccountType.google:
        return await handleGoogleSignIn();
      case AccountType.linkedin:
        return await handleLinkedInSignIn(linkedinUser);
      case AccountType.facebook:
        return await handleFacebookSignIn();
    }
  }

  logoutWith(AccountType logoutWith) async {
    switch (logoutWith) {
      case AccountType.google:
        return await handleGoogleLogout();
      case AccountType.linkedin:
        return;
      case AccountType.facebook:
        await facebookLoginPlugin.logOut();
        return;
    }
  }

  Future<User?> handleGoogleSignIn() async {
    try {
      GoogleSignInAccount? result = await googleSignIn.signIn();

      if (result != null) {
        return User(
          email: result.email,
          name: result.displayName,
          photoUrl: result.photoUrl,
        );
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<User?> handleLinkedInSignIn(LinkedInUserModel? linkedinUser) async {
    try {
      if (linkedinUser != null) {
        User user = User(
          email: linkedinUser.email?.elements?.first.handleDeep?.emailAddress,
          name:
              "${linkedinUser.firstName?.localized?.label} ${linkedinUser.lastName?.localized?.label}",
          photoUrl: linkedinUser.profilePicture?.displayImageContent?.elements
              ?.elementAt(0)
              .identifiers
              ?.elementAt(0)
              .identifier,
        );
        return user;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<User?> handleFacebookSignIn() async {
    try {
      FacebookLoginResult result =
          await facebookLoginPlugin.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

      final token = result.accessToken;
      FacebookUserProfile? profile;
      String? email;
      String? imageUrl;

      if (token != null) {
        profile = await facebookLoginPlugin.getUserProfile();
        if (token.permissions.contains(FacebookPermission.email.name)) {
          email = await facebookLoginPlugin.getUserEmail();
        }
        imageUrl = await facebookLoginPlugin.getProfileImageUrl(width: 100);
        Logger().d("Rupali -- $imageUrl");
        User user = User(
          email: email,
          name: profile?.name,
          photoUrl: imageUrl,
        );
        return user;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<GoogleSignInAccount?> handleGoogleLogout() async {
    try {
      GoogleSignInAccount? result = await googleSignIn.signOut();
      //await deleteStoredData();

      return result;
    } catch (e) {
      return null;
    }
  }

  storeUserInfo(User user, AccountType loggedInType) async {
    await secureStorage.write(key: Constants.EMAIL, value: user.email);
    await secureStorage.write(key: Constants.DISPLAY_NAME, value: user.name);
    await secureStorage.write(
        key: Constants.PROFILE_PICTURE, value: user.photoUrl);
    await secureStorage.write(
        key: Constants.LoggedInAccountType, value: loggedInType.name);
  }

  deleteStoredData() async {
    await secureStorage.deleteAll();
  }

  Future<User> fetchUserInfo() async {
    String? name = await secureStorage.read(key: Constants.DISPLAY_NAME);
    String? email = await secureStorage.read(key: Constants.EMAIL);
    String? photoURL = await secureStorage.read(key: Constants.PROFILE_PICTURE);

    return User(name: name, email: email, photoUrl: photoURL);
  }

  fetchLoggedInType() async {
    return await secureStorage.read(key: Constants.LoggedInAccountType);
  }
}
