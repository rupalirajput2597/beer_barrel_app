import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../account/account.dart';
import '../core/core.dart';
import '../home/home.dart';
import '../navigator/app_router.dart';

init() {
  final apiClient = ApiClient(http.Client());
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  final DataRepository dataRepository = DataRepository(apiClient);
  const secureStorage = FlutterSecureStorage();
  final plugin = FacebookLogin(debug: true);
  _setStatusBarColor();
  final AuthRepository authRepository =
      AuthRepository(googleSignIn, secureStorage, plugin);

  runApp(
    BeerBarrelApp(
      dataRepository: dataRepository,
      authRepository: authRepository,
    ),
  );
}

class BeerBarrelApp extends StatelessWidget {
  final DataRepository dataRepository;
  final AuthRepository authRepository;
  const BeerBarrelApp(
      {required this.dataRepository, required this.authRepository, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => dataRepository,
        ),
        RepositoryProvider(
          create: (context) => authRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeCubit>(
            create: (_) => HomeCubit(dataRepository),
          ),
          BlocProvider<AccountCubit>(
            create: (_) => AccountCubit(authRepository),
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
      ),
    );
  }
}

//
void _setStatusBarColor() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: BBColor.pageBackground,
    statusBarIconBrightness: Brightness.light,
  ));
}
