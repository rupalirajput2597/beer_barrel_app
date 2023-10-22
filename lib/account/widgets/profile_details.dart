import 'package:beer_barrel/account/bloc/account_cubit.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';
import 'widgets.dart';

class ProfileDetailsWidget extends StatelessWidget {
  const ProfileDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      color: BBColor.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EmailNameFieldWidget(title: "Name", desc: "${user.name}"),
          const SizedBox(
            height: 20,
          ),
          EmailNameFieldWidget(title: "Email Id", desc: "${user.email}"),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
