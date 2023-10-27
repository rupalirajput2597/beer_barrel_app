import 'package:flutter/material.dart';

import '../core.dart';

enum SnackBarMessageType {
  success,
  error,
}

class SnackBarMessageWidget extends StatelessWidget {
  final String msg;
  final SnackBarMessageType msgType;
  const SnackBarMessageWidget(this.msg,
      {this.msgType = SnackBarMessageType.success, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: msgType == SnackBarMessageType.success
            ? BBColor.darkBlue
            : BBColor.red,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
