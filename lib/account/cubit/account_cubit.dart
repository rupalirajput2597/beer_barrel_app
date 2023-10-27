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

  signInWithSocialMediaAccount(AccountType loginWith,
      {LinkedInUserModel? linkedinUser}) async {
    try {
      User? userResult = await _authRepository.loginWithSocialMedia(
        loginWith,
        linkedinUser: linkedinUser,
      );

      if (userResult == null) {
        emit(UnauthenticatedAccountState());
      } else {
        user = userResult;
        emit(AuthenticatedAccountState());
        _postLogin(userResult, loginWith);
      }
    } on LoginWithGoogleFailure catch (e) {
      emit(AccountErrorState(e.message));
    } catch (e) {
      emit(AccountErrorState(Constants.unknownErrorMsg));
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
      emit(AccountErrorState(Constants.unknownErrorMsg));
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
      emit(AccountErrorState(Constants.unknownErrorMsg));
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
