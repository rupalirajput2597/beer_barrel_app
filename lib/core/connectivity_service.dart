import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class ConnectivityService extends ChangeNotifier {
  ConnectivityResult _result = ConnectivityResult.none;

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((result) {
      _result = result;
      notifyListeners();
    });
  }

  bool get isOnline => _result != ConnectivityResult.none;
}
