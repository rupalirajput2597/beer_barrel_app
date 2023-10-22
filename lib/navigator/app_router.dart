import 'package:beer_barrel/core/core.dart';
import 'package:beer_barrel/home/home_screen.dart';
import 'package:beer_barrel/product/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static const productDetailsPath = "/product";
  static const homeScreenPath = "/home";
  static const profilePath = "/profile";

  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: homeScreenPath,
    routes: [
      GoRoute(
        path: homeScreenPath,
        builder: (context, state) {
          return HomeScreen();
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
          return ProductDetailScreen(state.extra as Beer);
        },
      ),
    ],
    redirect: (context, state) {
      return null;
    },
  );
}
