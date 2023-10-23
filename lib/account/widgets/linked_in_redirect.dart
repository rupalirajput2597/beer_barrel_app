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
            content: Text(
              e.exception.toString(),
            ),
          ),
        );
      },
      onGetUserProfile: (final UserSucceededAction linkedInUser) {
        context
            .read<AccountCubit>()
            .signInWithLinkedIn(context, linkedInUser.user);
        context.pop();
      },
    );
  }
}
