import 'package:flutter/material.dart';

import '../core.dart';

class ErrorPage extends StatelessWidget {
  final Function onRefresh;
  final int statusCode;

  const ErrorPage({
    super.key,
    required this.statusCode,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(
              AssetHelper.appIconMedium,
              height: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    statusCode == 900
                        ? "The Internet connection appears to be offline"
                        : "SOMETHING’S NOT RIGHT",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Text(
                    statusCode == 900
                        ? "Please try connecting to a stable connection.\nRefresh the page. Sometimes works."
                        : "We are sorry, we are having some technical issues.\nRefresh the page. Sometimes works. ;)",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400, height: 1.5),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onRefresh();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.refresh,
                        size: 28,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "REFRESH",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
