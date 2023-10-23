import 'package:beer_barrel/account/cubit/account_cubit.dart';
import 'package:beer_barrel/account/cubit/account_state.dart';
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
                _navigateToHome();
              }
              if (state is AccountErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.errorMessage!,
                    ),
                  ),
                );
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Image.asset(
                      AssetHelper.appIconMedium,
                      // height: 200,
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
                const SizedBox(
                  height: 16,
                ),
                _googleSignIn(),
                // _facebookSignIn(),
                _linkedinSignIn(),
                const SizedBox(
                  height: 40,
                )
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
        _cubit.signInWithGoogle(context);
      },
    );
  }

  Widget _linkedinSignIn() {
    return SignInButton(
      logo: AssetHelper.linkedinIconLarge,
      title: "LinkedIn",
      titleColor: BBColor.white,
      backgroundColor: BBColor.linkedInBG,
      onPressed: () {
        context.push(AppRouter.linkedInRedirect);
      },
    );
  }

  void _navigateToHome() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Login Successful !!!",
          style: TextStyle(
            color: BBColor.darkBlue,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
    context.pushReplacement(AppRouter.homeScreenPath);
  }

//facebook now requires all NEWLY entered package names to be associated with a valid google play store URL https://developers.facebook.com/support/bugs/1307870196812047/?join_id=f12e5a3b52a432
  Widget _facebookSignIn() {
    return SignInButton(
      logo: AssetHelper.facebookIconLarge,
      title: "Facebook",
      titleColor: BBColor.white,
      backgroundColor: BBColor.facebookBG,
      onPressed: () {},
    );
  }
}
