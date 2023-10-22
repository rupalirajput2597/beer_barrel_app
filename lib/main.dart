import 'package:beer_barrel/account/bloc/account_cubit.dart';
import 'package:beer_barrel/core/api/api.dart';
import 'package:beer_barrel/core/core.dart';
import 'package:beer_barrel/core/repository/data_repo.dart';
import 'package:beer_barrel/firebase_options.dart';
import 'package:beer_barrel/home/home.dart';
import 'package:beer_barrel/navigator/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final apiClient = ApiClient(http.Client());

  runApp(MultiRepositoryProvider(providers: [
    RepositoryProvider(
      create: (context) => DataRepository(apiClient),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
        // home: const HomeScreen(),
      ),
    );
  }
}
