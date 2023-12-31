import 'package:beer_barrel/account/widgets/linked_in_redirect.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../account/login_screen.dart';
import '../core/core.dart';
import '../home/home.dart';
import '../product/product_detail_screen.dart';
import '../splash/splash_screen.dart';
import '../user/user_profile_screen.dart';

//go_router implementation
class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static const productDetailsPath = "/product";
  static const homeScreenPath = "/home";
  static const profilePath = "/profile";
  static const loginScreenPath = "/login";
  static const splashScreenPath = "/splash";
  static const linkedInRedirect = "/linkedIn-redirect";

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
      GoRoute(
        path: linkedInRedirect,
        builder: (context, state) {
          return const LinkedInRedirect();
        },
      ),
    ],
    redirect: (context, state) {
      return null;
    },
  );
}
