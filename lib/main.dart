import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main/app.dart' as app;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure portrait orientation only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  app.init();
}
