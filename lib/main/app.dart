import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../account/account.dart';
import '../core/core.dart';
import '../home/home.dart';
import '../navigator/app_router.dart';

init() {
  final apiClient = ApiClient(http.Client());
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DataRepository(apiClient),
        ),
        RepositoryProvider(
          create: (context) => AuthRepository(googleSignIn),
        ),
      ],
      child: const BeerBarrelApp(),
    ),
  );
}

class BeerBarrelApp extends StatelessWidget {
  const BeerBarrelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(),
        ),
        BlocProvider<AccountCubit>(
          create: (_) => AccountCubit(),
        ),
      ],
      child: MaterialApp.router(
        routeInformationParser: AppRouter.router.routeInformationParser,
        routerDelegate: AppRouter.router.routerDelegate,
        routeInformationProvider: AppRouter.router.routeInformationProvider,
        title: 'Beer Barrel',
        theme: BBAppTheme.theme(context),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0,
            ),
            child: child!,
          );
        },
      ),
    );
  }
}
