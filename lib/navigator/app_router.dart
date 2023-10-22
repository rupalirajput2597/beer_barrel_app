import 'package:beer_barrel/core/core.dart';
import 'package:beer_barrel/home/home_screen.dart';
import 'package:beer_barrel/product/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../account/login_screen.dart';
import '../account/profile_screen.dart';
import '../splash/splash_screen.dart';

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static const productDetailsPath = "/product";
  static const homeScreenPath = "/home";
  static const profilePath = "/profile";
  static const loginScreenPath = "/login";
  static const splashScreenPath = "/splash";

  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: splashScreenPath,
    routes: [
      GoRoute(
        path: splashScreenPath,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: loginScreenPath,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: homeScreenPath,
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: productDetailsPath,
        builder: (context, state) {
          return ProductDetailScreen(state.extra as Beer);
        },
      ),
      GoRoute(
        path: profilePath,
        builder: (context, state) {
          return const ProfileScreen();
        },
      ),
    ],
    redirect: (context, state) {
      return null;
    },
  );
}
