import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/core.dart';
import '../navigator/app_router.dart';
import 'account.dart';

//User Profile Screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BBColor.white,
      body: BlocListener<AccountCubit, AccountState>(
        listener: (context, state) {
          if (state is LogoutSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Logout Successful!!",
                  style: TextStyle(
                    color: BBColor.darkBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            );
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
          const CustomBackButton(),
          _profileContent(context),
          LogoutButton(
            onPress: () {
              showDialog(
                context: context,
                builder: (context) {
                  return _showLogoutConfirmation(context);
                },
              );
            },
          ),
        ],
      ),
    );
  }

//Profile Data
  _profileContent(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeaderOfProfileAndProductScreen(
              child: _previewImage(context),
            ),
            const UserProfileDetailsWidget(),
          ],
        ),
      ),
    );
  }

  //User Profile image
  Widget _previewImage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: user.photoUrl == null
            ? Container(
                color: BBColor.grey,
                height: 190,
                width: 190,
                child: Center(
                  child: Text(
                    "${user.name?[0]}",
                    style: TextStyle(
                        color: BBColor.pageBackground.withOpacity(0.5),
                        fontSize: 36,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              )
            : NetworkImageWidget(
                imageUrl: user.photoUrl ?? "",
                height: 190,
                width: 190,
              ),
      ),
    );
  }

  _showLogoutConfirmation(BuildContext context) {
    return ConfirmationDialog(
      titleText: "Logout",
      messageText: "Are You sure, Do you Want to Logout?",
      onConfirm: () {
        context.read<AccountCubit>().performGoogleLogOut(context);
      },
    );
  }
}
