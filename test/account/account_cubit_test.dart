import 'package:beer_barrel/account/account.dart';
import 'package:beer_barrel/core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AccountCubit accountCubit;
  final authRepository = MockAuthRepository();
  late User dummyUser;
  setUpAll(() {
    accountCubit = AccountCubit(authRepository);
    dummyUser = const User(
      email: 'https://example.com/photo.jpg',
      name: "Rupali Rajput",
      photoUrl: 'https://example.com/photo.jpg',
    );
  });

  group('AccountCubit', () {
    test('Initial state is InitialAccountState', () {
      expect(
        accountCubit.state,
        InitialAccountState(),
      );
    });

    test('Google-signin success should return AuthenticatedAccountState',
        () async {
      when(() => authRepository.loginWithSocialMedia(AccountType.google))
          .thenAnswer(
        (_) async => dummyUser,
      );

      await accountCubit.signInWithSocialMediaAccount(AccountType.google);

      expect(accountCubit.state, AuthenticatedAccountState());
    });
    test('facebook-signin success should return AuthenticatedAccountState',
        () async {
      when(() => authRepository.loginWithSocialMedia(AccountType.facebook))
          .thenAnswer(
        (_) async => dummyUser,
      );

      await accountCubit.signInWithSocialMediaAccount(AccountType.facebook);

      expect(accountCubit.state, AuthenticatedAccountState());
    });

    test('Google-signin fail should return AccountErrorState', () async {
      when(() => authRepository.loginWithSocialMedia(AccountType.google))
          .thenThrow(Exception('Login failed'));
      await accountCubit.signInWithSocialMediaAccount(AccountType.google);
      expect(
        accountCubit.state,
        AccountErrorState(Constants.unknownErrorMsg),
      );
    });

    test('LinkedIn signIn fail should return AccountErrorState', () async {
      when(() => authRepository.loginWithSocialMedia(AccountType.linkedin))
          .thenThrow(Exception('Login failed'));

      await accountCubit.signInWithSocialMediaAccount(AccountType.linkedin,
          linkedinUser: LinkedInUserModel(
            localizedFirstName: "Rupali",
            localizedLastName: "Rajput",
          ));

      expect(accountCubit.state, AccountErrorState(Constants.unknownErrorMsg));
    });

    test('Facebook signIn fail should return AccountErrorState', () async {
      when(() => authRepository.loginWithSocialMedia(AccountType.facebook))
          .thenThrow(Exception('Login failed'));

      await accountCubit.signInWithSocialMediaAccount(
        AccountType.facebook,
      );

      expect(accountCubit.state, AccountErrorState(Constants.unknownErrorMsg));
    });

    test('emits Authenticated state on alreadyLoggedIn User', () async {
      when(() => authRepository.fetchUserInfo())
          .thenAnswer((_) async => dummyUser);

      await accountCubit.alreadyLoggedIn();

      expect(accountCubit.state, AuthenticatedAccountState());
    });

    test('emits unauthenticated state if user is not alreadyLoggedIn',
        () async {
      when(() => authRepository.fetchUserInfo()).thenAnswer(
          (_) async => User(name: null, email: null, photoUrl: null));

      await accountCubit.alreadyLoggedIn();

      expect(accountCubit.state, UnauthenticatedAccountState());
    });
  });
}
