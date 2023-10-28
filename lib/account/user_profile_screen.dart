import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/core.dart';
import '../navigator/app_router.dart';
import 'account.dart';

//User Profile Screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const double profileHeightWidth = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BBColor.white,
      body: BlocListener<AccountCubit, AccountState>(
        listener: (context, state) {
          if (state is LogoutSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: SnackBarMessageWidget(
                  "Successfully Logout!!",
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
      padding: const EdgeInsets.only(top: 60),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: user?.photoUrl == null
            ? _profilePlaceHolder()
            : NetworkImageWidget(
                imageUrl: user?.photoUrl ?? "",
                height: profileHeightWidth,
                width: profileHeightWidth,
                errorWidget: _profilePlaceHolder(),
              ),
      ),
    );
  }

  _showLogoutConfirmation(BuildContext context) {
    return ConfirmationDialog(
      titleText: "Logout",
      messageText: "Are you sure ${user?.name}, Do you want to logout?",
      onConfirm: () {
        context.read<AccountCubit>().performLogout();
      },
    );
  }

  Widget _profilePlaceHolder() {
    return Container(
      color: BBColor.grey,
      height: profileHeightWidth,
      width: profileHeightWidth,
      child: Center(
        child: Text(
          "${user?.name?[0]}",
          style: TextStyle(
            color: BBColor.pageBackground.withOpacity(0.5),
            fontSize: 36,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
