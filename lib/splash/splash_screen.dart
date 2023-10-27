import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../account/account.dart';
import '../core/core.dart';
import '../navigator/app_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AccountCubit, AccountState>(
          listener: (context, state) {
            if (state is AuthenticatedAccountState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: SnackBarMessageWidget(
                  "Welcome back, ${user?.name}!!",
                )),
              );
              //Navigating to Home page if user is already logged-in
              context.pushReplacement(AppRouter.homeScreenPath);
            }
            if (state is UnauthenticatedAccountState) {
              //Navigating to Login page if user is not logged-in yet
              context.pushReplacement(AppRouter.loginScreenPath);
            }
          },
          builder: (context, state) {
            if (state is InitialAccountState) {
              context.read<AccountCubit>().alreadyLoggedIn();
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 36.0,
                ),
                child: Image.asset(
                  AssetHelper.appIconMedium,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
