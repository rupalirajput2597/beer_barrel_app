import 'package:beer_barrel/account/bloc/account_cubit.dart';
import 'package:beer_barrel/account/bloc/account_state.dart';
import 'package:beer_barrel/core/core.dart';
import 'package:beer_barrel/navigator/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AccountCubit, AccountState>(
          listener: (context, state) {
            if (state is AuthenticatedAccountState) {
              context.pushReplacement(AppRouter.homeScreenPath);
            }
            if (state is UnauthenticatedAccountState) {
              context.pushReplacement(AppRouter.loginScreenPath);
            }
          },
          builder: (context, state) {
            if (state is InitialAccountState) {
              context.read<AccountCubit>().alreadyLoggedIn();
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
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
