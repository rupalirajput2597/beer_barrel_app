import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkedin_login/linkedin_login.dart';

import '../../core/core.dart';
import '../../core/google_exception.dart';
import '../account.dart';

late User? user;
bool keepSession = false;
String? loggedInType;

//Account business logic
class AccountCubit extends Cubit<AccountState> {
  AccountCubit(this._authRepository) : super(InitialAccountState());
  final AuthRepository _authRepository;

  signInWithGoogle() async {
    try {
      User? userResult = await _authRepository.loginWithSocialMedia(
        AccountType.google,
      );

      if (userResult == null) {
        emit(UnauthenticatedAccountState());
      } else {
        user = userResult;
        emit(AuthenticatedAccountState());
        _postLogin(userResult, AccountType.google);
      }
    } on LoginWithGoogleFailure catch (e) {
      emit(AccountErrorState(e.message));
    } catch (e) {
      emit(AccountErrorState("Something went wrong :  Unknown Error occurred"));
    }
  }

  signInWithLinkedIn(LinkedInUserModel? linkedinUser) async {
    try {
      User? userResult = await _authRepository.loginWithSocialMedia(
          AccountType.linkedin,
          linkedinUser: linkedinUser);
      if (userResult == null) {
        emit(UnauthenticatedAccountState());
      } else {
        user = userResult;
        emit(AuthenticatedAccountState());
        _postLogin(userResult, AccountType.linkedin);
      }
    } on LoginWithGoogleFailure catch (e) {
      emit(AccountErrorState(e.message));
    } catch (e) {
      emit(AccountErrorState("Something went wrong :  Unknown Error occured"));
    }
  }

  performLogout() async {
    try {
      if (loggedInType == AccountType.google.name) {
        _authRepository.logoutWith(AccountType.google);
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

      User storedUserInfo = await _authRepository.fetchUserInfo();

      if (storedUserInfo.isNotEmpty) {
        user = storedUserInfo;
        keepSession = true;
        loggedInType = await _authRepository.fetchLoggedInType();
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

  void _postLogin(User user, AccountType loggedInWith) async {
    _authRepository.storeUserInfo(user, AccountType.google);
    keepSession = true;
    loggedInType = loggedInWith.name;
  }

  void _postLogout() async {
    user = null;
    keepSession = false;
    loggedInType = null;
    await _authRepository.deleteStoredData();
  }
}
