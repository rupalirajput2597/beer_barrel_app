import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkedin_login/linkedin_login.dart';

import '../../core/core.dart';
import '../cubit/account_cubit.dart';

class LinkedInRedirect extends StatefulWidget {
  const LinkedInRedirect({Key? key}) : super(key: key);

  @override
  State<LinkedInRedirect> createState() => _LinkedInRedirectState();
}

//Linkedin redirection
class _LinkedInRedirectState extends State<LinkedInRedirect> {
  @override
  Widget build(BuildContext context) {
    return LinkedInUserWidget(
      appBar: AppBar(
        title: const Text('oauth2/linked-in'),
      ),
      destroySession: !keepSession,
      redirectUrl: Constants.redirectUrl,
      clientId: Constants.clientId,
      clientSecret: Constants.clientSecret,
      projection: const [
        ProjectionParameters.id,
        ProjectionParameters.localizedFirstName,
        ProjectionParameters.localizedLastName,
        ProjectionParameters.firstName,
        ProjectionParameters.lastName,
        ProjectionParameters.profilePicture,
      ],
      onError: (final UserFailedAction e) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SnackBarMessageWidget(
              e.exception.toString(),
              msgType: SnackBarMessageType.error,
            ),
          ),
        );
      },
      onGetUserProfile: (final UserSucceededAction linkedInUser) {
        //  context.read<AccountCubit>().signInWithLinkedIn(linkedInUser.user);
        context.read<AccountCubit>().signInWithSocialMediaAccount(
            AccountType.linkedin,
            linkedinUser: linkedInUser.user);
        context.pop();
      },
    );
  }
}

//https://www.linkedin.com/developers/tools/oauth/redirect

//AuthToken
//AQW5X1DRFuj2mDIm2liyAvCpm1zfPqJdzXc5stXTH4bb3vZPukQ9Dq1bp34iYEL0m59NGexCi1DBP3TWRwGpIVdyXXDHEWnzpx9VGsQY6YZZb-fmOD058g4kjcDuyP_0uU_bWPqnYzqHL475t7rla1T6762osQ6gfc28Ie0OD_QGU2-FG-dqoHW0sX8tGocVPTmj08viScdSWlRWadN_YshKvoGR_68tagyFI8fZxuTgz2FvlrXqyXDOXjpdGey1LPJPYVSd0ZPAaY8Gx-c6DhvG2uQNTCA4azX6Sp7XGvhg3OGBx7HHBjTWAMlPsr0DyHHs464MRVQ9RsbhlRHu3zVnim3DbA
