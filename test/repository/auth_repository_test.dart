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
    late FacebookLoginResult loginResult;
    late FacebookAccessToken accessToken;
    late FacebookUserProfile userProfile;

    setUpAll(() {
      mockGoogleSignIn = MockGoogleSignIn();
      mockGoogleSignInAccount = MockGoogleSignInAccount();
      mockSecureStorage = MockFlutterSecureStorage();

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

      mockFacebookLogin = MockFacebookLogin();
      Map<String, dynamic> accessTokenMap = {
        "token": 'dummy_access_token',
        "userId": 'dummy_user_id',
        "permissions": const ['email'],
        'declinedPermissions': [],
        "expires": 3600,
      };
      accessToken = FacebookAccessToken.fromMap(accessTokenMap);
      loginResult = FacebookLoginResult.fromMap({
        "status": "Success",
        "accessToken": accessTokenMap, //accessToken,
        "error": null,
      });

      userProfile = FacebookUserProfile.fromMap({
        "userId": accessToken.userId,
        "email": userEmail,
        "name": userFullName,
      });

      when(() => mockFacebookLogin.logIn(
              permissions: captureAny(named: 'permissions')))
          .thenAnswer((_) async => loginResult);

      when(() => mockFacebookLogin.accessToken)
          .thenAnswer((_) async => accessToken);

      when(() => mockFacebookLogin.getUserProfile())
          .thenAnswer((_) async => userProfile);

      when(() => mockFacebookLogin.getUserEmail())
          .thenAnswer((_) async => userEmail);

      when(() => mockFacebookLogin.getProfileImageUrl(width: 100))
          .thenAnswer((_) async => userProfileUrl);

      authRepository = AuthRepository(
          mockGoogleSignIn, mockSecureStorage, mockFacebookLogin);
    });

    test('Google Sign-In should return a User Object', () async {
      when(() => mockGoogleSignIn.signIn())
          .thenAnswer((_) async => mockGoogleSignInAccount);
      when(() => mockGoogleSignInAccount.email).thenReturn(userEmail);
      when(() => mockGoogleSignInAccount.displayName).thenReturn(userFullName);
      when(() => mockGoogleSignInAccount.photoUrl).thenReturn(userProfileUrl);

      final result =
          await authRepository.loginWithSocialMedia(AccountType.google);

      expect(result, dummyUser);
    });

    test('Google-signin Should returns null on failure', () async {
      when(() => mockGoogleSignIn.signIn())
          .thenThrow(Exception('Google sign-in error'));
      final result = await authRepository.handleGoogleSignIn();
      expect(result, isNull);
    });

    test('Facebook sign-in should return an User Object', () async {
      AuthRepository authRepository = AuthRepository(
          MockGoogleSignIn(), MockFlutterSecureStorage(), mockFacebookLogin);
      final result = await authRepository.handleFacebookSignIn();

      expect(result, dummyUser);
    });

    test(
        'LinkedInSignIn should returns a User when LinkedInUserModel is provided',
        () async {
      final mockLinkedinUser = MockLinkedInUserModel();
      when(() => mockLinkedinUser.firstName).thenReturn(
        LinkedInPersonalInfo(
          localized: LinkedInLocalInfo(label: userFirstName),
        ),
      );
      when(() => mockLinkedinUser.lastName).thenReturn(
        LinkedInPersonalInfo(
          localized: LinkedInLocalInfo(label: userLastName),
        ),
      );
      when(() => mockLinkedinUser.email)
          .thenReturn(LinkedInProfileEmail(elements: [
        LinkedInDeepEmail(
          handleDeep: LinkedInDeepEmailHandle(emailAddress: userEmail),
        ),
      ]));

      final user = await authRepository.handleLinkedInSignIn(
        mockLinkedinUser,
      );

      expect(
        user,
        User(email: userEmail, name: userFullName),
      ); // Ensure user is not null
    });

    test('LinkedInSignIn returns null on null user', () async {
      final result = await authRepository.handleLinkedInSignIn(
        null,
      );
      expect(result, isNull);
    });

    test('store user info in secure storage', () async {
      when(() => mockSecureStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'))).thenAnswer((_) async {});

      await authRepository.storeUserInfo(dummyUser, AccountType.google);

      verify(() =>
              mockSecureStorage.write(key: Constants.email, value: userEmail))
          .called(1);
      verify(() => mockSecureStorage.write(
          key: Constants.displayName, value: userFullName)).called(1);
      verify(() => mockSecureStorage.write(
          key: Constants.profilePicture, value: userProfileUrl)).called(1);
      verify(() => mockSecureStorage.write(
          key: Constants.loggedInAccountType, value: 'google')).called(1);
    });

    test('delete all data from secure storage', () async {
      when(() => mockSecureStorage.deleteAll()).thenAnswer((_) async {});
      await authRepository.deleteStoredData();
      verify(() => mockSecureStorage.deleteAll()).called(1);
    });

    test('fetchUserInfo() method should returns User object with stored data',
        () async {
      when(() => mockSecureStorage.read(key: Constants.displayName))
          .thenAnswer((_) async => userFullName);
      when(() => mockSecureStorage.read(key: Constants.email))
          .thenAnswer((_) async => userEmail);
      when(() => mockSecureStorage.read(key: Constants.profilePicture))
          .thenAnswer((_) async => userProfileUrl);

      final result = await authRepository.fetchUserInfo();

      expect(result, dummyUser);
    });

    test(
        'fetchUserInfo() should returns User object with null data if not stored',
        () async {
      //Arrange
      when(() => mockSecureStorage.read(key: Constants.displayName))
          .thenAnswer((_) async => null);
      when(() => mockSecureStorage.read(key: Constants.email))
          .thenAnswer((_) async => null);
      when(() => mockSecureStorage.read(key: Constants.profilePicture))
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
      when(() => mockSecureStorage.read(key: Constants.loggedInAccountType))
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
      when(() => mockSecureStorage.read(key: Constants.loggedInAccountType))
          .thenAnswer((_) async => null);
      //act
      final accountType = await authRepository.fetchLoggedInType();
      //assert
      expect(accountType, isNull);
    });
  });
}
