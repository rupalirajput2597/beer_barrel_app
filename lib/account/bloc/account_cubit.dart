import 'dart:io';

import 'package:beer_barrel/account/bloc/account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/auth_mixin.dart';
import '../../core/core.dart';

late User user;

class AccountCubit extends Cubit<AccountState> with AuthenticationMixin {
  AccountCubit() : super(InitialAccountState());
  static const secureStorage = FlutterSecureStorage();

  signInWithGoogle(BuildContext context) async {
    try {
      await handleSignIn();
    } on SocketException catch (e) {
      emit(AccountErrorState());
    } catch (e) {
      emit(AccountErrorState());
    }
  }

  performLogOut(BuildContext context) async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
      await googleSignIn.signOut();
      await secureStorage.deleteAll();
      emit(LogoutSuccessState());
    } catch (e) {
      emit(AccountErrorState());
    }
  }

  alreadyLoggedIn() async {
    try {
      emit(CheckingAuthenticationState());
      String? name = await secureStorage.read(key: Constants.DISPLAY_NAME);
      String? email = await secureStorage.read(key: Constants.EMAIL);
      String? photoURL =
          await secureStorage.read(key: Constants.PROFILE_PICTURE);

      user = User(email: email, name: name, photoUrl: photoURL);

      if (name != null && email != null) {
        emit(AuthenticatedAccountState());
      } else {
        emit(UnauthenticatedAccountState());
      }
    } catch (e) {
      emit(AccountErrorState());
    }
  }

  handleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

    try {
      GoogleSignInAccount? result = await googleSignIn.signIn();
      if (result == null) {
        emit(UnauthenticatedAccountState());
      } else {
        secureStorage.write(key: Constants.EMAIL, value: result.email);
        secureStorage.write(
            key: Constants.DISPLAY_NAME, value: result.displayName);
        secureStorage.write(
            key: Constants.PROFILE_PICTURE, value: result.photoUrl);

        user = User(
            email: result.email,
            name: result.displayName,
            photoUrl: result.photoUrl);

        emit(AuthenticatedAccountState());
      }
    } catch (error) {
      emit(AccountErrorState());
    }
  }
}

/*    // try {
    //   final authResult = await googleAuthentication();
    //   print(
    //       "authResult.userName -- ${authResult.userName}, email -- ${authResult.email}");
    //
    //   final credential = GoogleAuthProvider.credential(
    //     accessToken: authResult.authToken,
    //     idToken: authResult.authId,
    //   );
    //   final userCred =
    //       await FirebaseAuth.instance.signInWithCredential(credential);
    //   print("userCred -- ${userCred.user?.email}");
    // } catch (error) {
    //   print("error -- ${error}");
    // } */
