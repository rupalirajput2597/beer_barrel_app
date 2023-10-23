import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:linkedin_login/linkedin_login.dart';

import '../../core/core.dart';
import '../../core/google_exception.dart';
import '../account.dart';

late User? user;
bool keepSession = false;
String? loggedInType;

//Account business logic
class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(InitialAccountState());
  static const secureStorage = FlutterSecureStorage();

  signInWithGoogle(BuildContext context) async {
    try {
      AuthRepository repository =
          RepositoryProvider.of<AuthRepository>(context);
      User? userResult = await repository.loginWithSocialMedia(
        AccountType.google,
      );

      if (userResult == null) {
        emit(UnauthenticatedAccountState());
      } else {
        user = userResult;
        _postLogin(AccountType.google.name);
        emit(AuthenticatedAccountState());
      }
    } on LoginWithGoogleFailure catch (e) {
      emit(AccountErrorState(e.message));
    } catch (e) {
      emit(AccountErrorState("Something went wrong :  Unknown Error occured"));
    }
  }

  signInWithLinkedIn(
      BuildContext context, LinkedInUserModel? linkedinUser) async {
    try {
      AuthRepository repository =
          RepositoryProvider.of<AuthRepository>(context);
      User? userResult = await repository.loginWithSocialMedia(
          AccountType.linkedin,
          linkedinUser: linkedinUser);
      if (userResult == null) {
        emit(UnauthenticatedAccountState());
      } else {
        user = userResult;
        _postLogin(AccountType.linkedin.name);
        emit(AuthenticatedAccountState());
      }
    } on LoginWithGoogleFailure catch (e) {
      emit(AccountErrorState(e.message));
    } catch (e) {
      emit(AccountErrorState("Something went wrong :  Unknown Error occured"));
    }
  }

  performLogout(BuildContext context) async {
    try {
      if (loggedInType == AccountType.google.name) {
        AuthRepository repository =
            RepositoryProvider.of<AuthRepository>(context);
        repository.LogoutWith(AccountType.google);
      }
      _postLogout();
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

      if (name != null && email != null) {
        keepSession = true;
        loggedInType =
            await secureStorage.read(key: Constants.LoggedInAccountType);
        user = User(email: email, name: name, photoUrl: photoURL);

        emit(AuthenticatedAccountState());
      } else {
        keepSession = false;
        emit(UnauthenticatedAccountState());
      }
    } on LoginWithGoogleFailure catch (e) {
      emit(AccountErrorState(e.message));
    } catch (e) {
      emit(AccountErrorState("Something went wrong :  Unknown Error occured"));
    }
  }

  void _postLogin(String loggedInWith) async {
    await secureStorage.write(key: Constants.EMAIL, value: user?.email);
    await secureStorage.write(key: Constants.DISPLAY_NAME, value: user?.name);
    await secureStorage.write(
        key: Constants.PROFILE_PICTURE, value: user?.photoUrl);
    await secureStorage.write(
        key: Constants.LoggedInAccountType, value: loggedInType);
    keepSession = true;
    loggedInType = loggedInWith;
  }

  void _postLogout() async {
    user = null;
    keepSession = false;
    loggedInType = null;
    await secureStorage.deleteAll();
  }
}
