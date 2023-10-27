import 'package:beer_barrel/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main/app.dart' as app;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Ensure portrait orientation only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  app.init();
}
