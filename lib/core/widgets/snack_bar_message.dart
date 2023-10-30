import 'package:flutter/material.dart';

enum SnackBarMessageType {
  success,
  error,
}

showSnackBar(BuildContext context, String msg,
    {SnackBarMessageType msgType = SnackBarMessageType.success,
    Duration? duration}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.horizontal,
      backgroundColor:
          msgType == SnackBarMessageType.success ? Colors.green : Colors.red,
      duration: duration ?? const Duration(seconds: 1),
      content: SnackBarMessageWidget(msg),
    ),
  );
}

class SnackBarMessageWidget extends StatelessWidget {
  final String msg;
  const SnackBarMessageWidget(this.msg, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white, //BBColor.darkBlue
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
