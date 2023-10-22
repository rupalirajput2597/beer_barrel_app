import 'package:beer_barrel/account/bloc/account_cubit.dart';
import 'package:beer_barrel/account/bloc/account_state.dart';
import 'package:beer_barrel/account/widgets/logout_button.dart';
import 'package:beer_barrel/account/widgets/profile_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/core.dart';
import '../navigator/app_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BBColor.white,
      body: BlocListener<AccountCubit, AccountState>(
        listener: (context, state) {
          if (state is LogoutSuccessState) {
            context.pushReplacement(AppRouter.loginScreenPath);
          }
        },
        child: _content(context),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomeBackButton(),
          _scrollableView(context),
          LogoutButton(
            onPress: () {
              context.read<AccountCubit>().performLogOut(context);
            },
          ),
        ],
      ),
    );
  }

  _scrollableView(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeaderOfProfileAndProductScreen(
              child: _previewImage(context),
            ),
            const ProfileDetailsWidget(),
          ],
        ),
      ),
    );
  }

  Widget _previewImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: NetworkImageWidget(
          imageUrl: user.photoUrl ?? "",
          height: MediaQuery.of(context).size.height * 0.24, //200
          width: MediaQuery.of(context).size.height * 0.24,
        ),
      ),
    );
  }
}
