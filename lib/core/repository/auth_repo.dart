import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkedin_login/linkedin_login.dart';

import '../core.dart';

enum AccountType { google, linkedin, facebook }

//Beer Barrel User Authentication Repository
class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLoginPlugin;
  final FlutterSecureStorage _secureStorage;
  AuthRepository(
      this._googleSignIn, this._secureStorage, this._facebookLoginPlugin);

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

  logoutAction(AccountType logoutWith) async {
    switch (logoutWith) {
      case AccountType.google:
        return await _googleSignIn.signOut();
      case AccountType.facebook:
        return await _facebookLoginPlugin.logOut();
      case AccountType.linkedin:
        return;
    }
  }

  Future<User?> handleGoogleSignIn() async {
    try {
      GoogleSignInAccount? result = await _googleSignIn.signIn();
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
      await _facebookLoginPlugin.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

      final token = await _facebookLoginPlugin.accessToken;
      FacebookUserProfile? profile;
      String? email;
      String? imageUrl;

      if (token != null) {
        profile = await _facebookLoginPlugin.getUserProfile();
        if (token.permissions.contains(FacebookPermission.email.name)) {
          email = await _facebookLoginPlugin.getUserEmail();
        }
        imageUrl = await _facebookLoginPlugin.getProfileImageUrl(width: 100);
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

  storeUserInfo(User user, AccountType loggedInType) async {
    await _secureStorage.write(key: Constants.email, value: user.email);
    await _secureStorage.write(key: Constants.displayName, value: user.name);
    await _secureStorage.write(
        key: Constants.profilePicture, value: user.photoUrl);
    await _secureStorage.write(
        key: Constants.loggedInAccountType, value: loggedInType.name);
  }

  deleteStoredData() async {
    await _secureStorage.deleteAll();
  }

  Future<User> fetchUserInfo() async {
    String? name = await _secureStorage.read(key: Constants.displayName);
    String? email = await _secureStorage.read(key: Constants.email);
    String? photoURL = await _secureStorage.read(key: Constants.profilePicture);

    return User(name: name, email: email, photoUrl: photoURL);
  }

  fetchLoggedInType() async {
    return await _secureStorage.read(key: Constants.loggedInAccountType);
  }
}
