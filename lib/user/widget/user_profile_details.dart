import 'package:flutter/material.dart';

import '../../account/account.dart';
import '../../core/core.dart';
import '../user.dart';

class UserProfileDetailsWidget extends StatelessWidget {
  const UserProfileDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      alignment: Alignment.center,
      color: BBColor.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EmailNameFieldWidget(title: "Name", desc: "${user?.name}"),
          const SizedBox(
            height: 20,
          ),
          EmailNameFieldWidget(title: "Email Id", desc: "${user?.email}"),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
