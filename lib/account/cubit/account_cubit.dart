import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/core.dart';
import '../../core/google_exception.dart';
import '../account.dart';

late User user;

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(InitialAccountState());
  static const secureStorage = FlutterSecureStorage();

  signInWithGoogle(BuildContext context) async {
    try {
      AuthRepository repository =
          RepositoryProvider.of<AuthRepository>(context);
      GoogleSignInAccount? result =
          await repository.loginWithSocialMedia(AccountType.google);

      if (result == null) {
        emit(UnauthenticatedAccountState());
      } else {
        _postLogin(result);
        emit(AuthenticatedAccountState());
      }
    } on LoginWithGoogleFailure catch (e) {
      emit(AccountErrorState(e.message));
    } catch (e) {
      emit(AccountErrorState("Something went wrong :  Unknown Error occured"));
    }
  }

  performGoogleLogOut(BuildContext context) async {
    try {
      AuthRepository repository =
          RepositoryProvider.of<AuthRepository>(context);
      repository.LogoutWith(AccountType.google);
      await secureStorage.deleteAll();
      emit(LogoutSuccessState());
    } on LoginWithGoogleFailure catch (e) {
      emit(AccountErrorState(e.message));
    } catch (e) {
      emit(AccountErrorState("Something went wrong :  Unknown Error occured"));
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
    } on LoginWithGoogleFailure catch (e) {
      emit(AccountErrorState(e.message));
    } catch (e) {
      emit(AccountErrorState("Something went wrong :  Unknown Error occured"));
    }
  }

  void _postLogin(GoogleSignInAccount result) {
    secureStorage.write(key: Constants.EMAIL, value: result.email);
    secureStorage.write(key: Constants.DISPLAY_NAME, value: result.displayName);
    secureStorage.write(key: Constants.PROFILE_PICTURE, value: result.photoUrl);

    user = User(
        email: result.email,
        name: result.displayName,
        photoUrl: result.photoUrl);
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
