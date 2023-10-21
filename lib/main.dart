import 'package:beer_barrel/core/core.dart';
import 'package:beer_barrel/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beer Barrel',
      theme: BBAppTheme.theme(context),
      home: const HomeScreen(),
    );
  }
}
