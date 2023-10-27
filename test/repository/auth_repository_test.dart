import 'package:beer_barrel/core/core.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:mocktail/mocktail.dart';

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockLinkedInUserModel extends Mock implements LinkedInUserModel {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

class MockFacebookLogin extends Mock implements FacebookLogin {}

void main() {
  group('AuthRepository', () {
    late AuthRepository authRepository;
    late MockGoogleSignIn mockGoogleSignIn;
    late MockGoogleSignInAccount mockGoogleSignInAccount;
    late MockFlutterSecureStorage mockSecureStorage;
    late MockFacebookLogin mockFacebookLogin;
    late String userEmail;
    late String userFullName;
    late String userFirstName;
    late String userLastName;
    late String userProfileUrl;
    late User dummyUser;

    setUpAll(() {
      mockGoogleSignIn = MockGoogleSignIn();
      mockGoogleSignInAccount = MockGoogleSignInAccount();
      mockSecureStorage = MockFlutterSecureStorage();
      mockFacebookLogin = MockFacebookLogin();
      authRepository = AuthRepository(
          mockGoogleSignIn, mockSecureStorage, mockFacebookLogin);

      userEmail = "rupalirajput@example.com";
      userFullName = "Rupali Rajput";
      userProfileUrl = 'https://example.com/photo.jpg';
      userFirstName = "Rupali";
      userLastName = "Rajput";
      dummyUser = User(
        email: userEmail,
        name: userFullName,
        photoUrl: userProfileUrl,
      );
    });

    test('Google Sign-In should return a User Object', () async {
      when(() => mockGoogleSignIn.signIn())
          .thenAnswer((_) => Future.value(mockGoogleSignInAccount));
      when(() => mockGoogleSignInAccount.email).thenReturn(userEmail);
      when(() => mockGoogleSignInAccount.displayName).thenReturn(userFullName);
      when(() => mockGoogleSignInAccount.photoUrl).thenReturn(userProfileUrl);

      final result =
          await authRepository.loginWithSocialMedia(AccountType.google);

      expect(result, dummyUser);
    });

    test('Google-signin Should returns null on failure', () async {
      // Arrange
      when(() => mockGoogleSignIn.signIn())
          .thenThrow(Exception('Google sign-in error'));
      // Act
      final result = await authRepository.handleGoogleSignIn();
      // Assert
      expect(result, isNull);
    });

    test('Google Sign-In should return a User Object', () async {
      when(() => mockGoogleSignIn.signIn())
          .thenAnswer((_) => Future.value(mockGoogleSignInAccount));
      when(() => mockGoogleSignInAccount.email).thenReturn(userEmail);
      when(() => mockGoogleSignInAccount.displayName).thenReturn(userFullName);
      when(() => mockGoogleSignInAccount.photoUrl).thenReturn(userProfileUrl);

      final result =
          await authRepository.loginWithSocialMedia(AccountType.google);

      expect(result, dummyUser);
    });

    test(
        'LinkedInSignIn should returns a User when LinkedInUserModel is provided',
        () async {
      // Arrange
      final mockLinkedinUser = MockLinkedInUserModel();
      when(() => mockLinkedinUser.firstName).thenReturn(LinkedInPersonalInfo(
          localized: LinkedInLocalInfo(label: userFirstName)));
      when(() => mockLinkedinUser.lastName).thenReturn(LinkedInPersonalInfo(
          localized: LinkedInLocalInfo(label: userLastName)));
      when(() => mockLinkedinUser.email)
          .thenReturn(LinkedInProfileEmail(elements: [
        LinkedInDeepEmail(
          handleDeep: LinkedInDeepEmailHandle(emailAddress: userEmail),
        ),
      ]));

      // Act
      final user = await authRepository.handleLinkedInSignIn(
        mockLinkedinUser,
      );
      // Assert
      expect(
        user,
        User(email: userEmail, name: userFullName),
      ); // Ensure user is not null
    });

    test('LinkedInSignIn returns null on null user', () async {
      // Act
      final result = await authRepository.handleLinkedInSignIn(
        null,
      );
      // Assert
      expect(result, isNull);
    });

    test('store user info in secure storage', () async {
      when(() => mockSecureStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'))).thenAnswer((_) async {});

      await authRepository.storeUserInfo(dummyUser, AccountType.google);

      verify(() =>
              mockSecureStorage.write(key: Constants.EMAIL, value: userEmail))
          .called(1);
      verify(() => mockSecureStorage.write(
          key: Constants.DISPLAY_NAME, value: userFullName)).called(1);
      verify(() => mockSecureStorage.write(
          key: Constants.PROFILE_PICTURE, value: userProfileUrl)).called(1);
      verify(() => mockSecureStorage.write(
          key: Constants.LoggedInAccountType, value: 'google')).called(1);
    });

    test('delete all data from secure storage', () async {
      //Arrange
      when(() => mockSecureStorage.deleteAll()).thenAnswer((_) async {});
      //Act
      await authRepository.deleteStoredData();
      //Assert
      verify(() => mockSecureStorage.deleteAll()).called(1);
    });

    test('fetchUserInfo() method should returns User object with stored data',
        () async {
      //Arrange
      when(() => mockSecureStorage.read(key: Constants.DISPLAY_NAME))
          .thenAnswer((_) async => userFullName);
      when(() => mockSecureStorage.read(key: Constants.EMAIL))
          .thenAnswer((_) async => userEmail);
      when(() => mockSecureStorage.read(key: Constants.PROFILE_PICTURE))
          .thenAnswer((_) async => userProfileUrl);

      //Act
      final result = await authRepository.fetchUserInfo();

      //Assert
      expect(result, dummyUser);
    });

    test(
        'fetchUserInfo() should returns User object with null data if not stored',
        () async {
      //Arrange
      when(() => mockSecureStorage.read(key: Constants.DISPLAY_NAME))
          .thenAnswer((_) async => null);
      when(() => mockSecureStorage.read(key: Constants.EMAIL))
          .thenAnswer((_) async => null);
      when(() => mockSecureStorage.read(key: Constants.PROFILE_PICTURE))
          .thenAnswer((_) async => null);
      //Act

      final result = await authRepository.fetchUserInfo();
      //Assert
      expect(result.email, isNull);
      expect(result.photoUrl, isNull);
    });

    test('fetchLoggedInType() method should returns the loggedIn account type',
        () async {
      //Arrange
      when(() => mockSecureStorage.read(key: Constants.LoggedInAccountType))
          .thenAnswer((_) async => 'google');
      //Act
      final accountType = await authRepository.fetchLoggedInType();
      //Assert
      expect(accountType, 'google');
    });

    test(
        'fetchLoggedInType() method returns null if the account type is not stored',
        () async {
      //Arrange
      when(() => mockSecureStorage.read(key: Constants.LoggedInAccountType))
          .thenAnswer((_) async => null);
      //act
      final accountType = await authRepository.fetchLoggedInType();
      //assert
      expect(accountType, isNull);
    });
  });
}
