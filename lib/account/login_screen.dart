import 'package:beer_barrel/account/cubit/account_cubit.dart';
import 'package:beer_barrel/account/cubit/account_state.dart';
import 'package:beer_barrel/core/core.dart';
import 'package:beer_barrel/navigator/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
                showSnackBar(
                  context,
                  "${state.errorMessage}",
                  msgType: SnackBarMessageType.error,
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
                Consumer<ConnectivityService>(
                  builder: (context, connectivityService, child) {
                    return Column(
                      children: [
                        _googleSignIn(connectivityService.isOnline),
                        _facebookSignIn(connectivityService.isOnline),
                        _linkedinSignIn(connectivityService.isOnline),
                        _noInternetMsg(connectivityService.isOnline),
                      ],
                    );
                  },
                ),
              ],
            ),
          )),
    );
  }

  Widget _googleSignIn(bool isOnline) {
    print(ConnectivityService().isOnline);
    return SignInButton(
        logo: AssetHelper.googleIconLarge,
        title: "Google",
        titleColor: BBColor.pageBackground,
        backgroundColor: BBColor.white,
        onPressed: !isOnline
            ? null
            : () {
                _cubit.signInWithSocialMediaAccount(AccountType.google);
              });
  }

  Widget _linkedinSignIn(bool isOnline) {
    return SignInButton(
      logo: AssetHelper.linkedinIconLarge,
      title: "LinkedIn",
      titleColor: BBColor.white,
      backgroundColor: BBColor.linkedInBG,
      onPressed: !isOnline
          ? null
          : () {
              context.push(AppRouter.linkedInRedirect);
            },
    );
  }

  void _navigateToHome() {
    showSnackBar(
      context,
      "Logged in successfully : Welcome to Beer Barrel, ${user?.name}",
    );
    context.pushReplacement(AppRouter.homeScreenPath);
  }

  Widget _facebookSignIn(bool isOnline) {
    return SignInButton(
        logo: AssetHelper.facebookIconLarge,
        title: "Facebook",
        titleColor: BBColor.white,
        backgroundColor: BBColor.facebookBG,
        onPressed: !isOnline
            ? null
            : () {
                _cubit.signInWithSocialMediaAccount(AccountType.facebook);
              });
  }

  _noInternetMsg(bool isOnline) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      color: isOnline ? null : BBColor.red,
      child: (!isOnline)
          ? Text(
              "No internet connection!",
              style: TextStyle(color: BBColor.white),
            )
          : null,
    );
  }
}
