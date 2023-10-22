/*
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInDemo extends StatefulWidget {
  @override
  _SignInDemoState createState() => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign-In Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _handleSignIn,
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }
}
*/

import 'package:beer_barrel/account/bloc/account_cubit.dart';
import 'package:beer_barrel/account/bloc/account_state.dart';
import 'package:beer_barrel/core/core.dart';
import 'package:beer_barrel/navigator/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'widgets/sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AccountCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<AccountCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: BlocListener<AccountCubit, AccountState>(
            listener: (context, state) {
              if (state is AuthenticatedAccountState) {
                context.pushReplacement(AppRouter.homeScreenPath);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36.0),
                    child: Image.asset(
                      AssetHelper.appIconMedium,
                    ),
                  ),
                ),
                Text(
                  'Sign in with',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: BBColor.white),
                ),
                _googleSignIn(),
                _facebookSignIn(),
                _linkedinSignIn(),
              ],
            ),
          )),
    );
  }

  Widget _googleSignIn() {
    return SignInButton(
      logo: AssetHelper.googleIconLarge,
      title: "Google",
      titleColor: BBColor.pageBackground,
      backgroundColor: BBColor.white,
      onPressed: () {
        // context.pushReplacement(AppRouter.homeScreenPath);

        _cubit.signInWithGoogle(context);
      },
    );
  }

//Meta now requires all NEWLY entered package names to be associated with a valid google play store URL https://developers.facebook.com/support/bugs/1307870196812047/?join_id=f12e5a3b52a432
  Widget _facebookSignIn() {
    return SignInButton(
      logo: AssetHelper.facebookIconLarge,
      title: "Facebook",
      titleColor: BBColor.white,
      backgroundColor: BBColor.facebookBG, onPressed: () {},
      //onPressed: () {},
    );
  }

  Widget _linkedinSignIn() {
    return SignInButton(
      logo: AssetHelper.linkedinIconLarge,
      title: "LinkedIn",
      titleColor: BBColor.white,
      backgroundColor: BBColor.linkedInBG,
      onPressed: () {},
    );
  }
}
