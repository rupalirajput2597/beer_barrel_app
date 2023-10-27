import 'package:beer_barrel/core/core.dart';
import 'package:flutter/material.dart';

//Confirmation dialog while performing actions like logout
class ConfirmationDialog extends StatelessWidget {
  final String? titleText;
  final String? messageText;
  final Function()? onConfirm;

  const ConfirmationDialog(
      {super.key, this.titleText, this.messageText, this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        color: BBColor.white,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: Text(
                    "$titleText",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: BBColor.red,
                    ),
                  ),
                ),
                Text(
                  "$messageText",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: BBColor.pageBackground,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                _buttonRow(context)
              ],
            )),
      ),
    );
  }

  Widget _buttonRow(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Divider(
            height: 0,
            color: BBColor.grey,
            thickness: 0.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      color: BBColor.pageBackground,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              TextButton(
                onPressed: onConfirm,
                child: Text(
                  "Confirm",
                  style: TextStyle(
                      color: BBColor.darkBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
