import 'package:beer_barrel/core/api/api.dart';
import 'package:beer_barrel/core/core.dart';
import 'package:beer_barrel/core/repository/data_repo.dart';
import 'package:beer_barrel/home/home.dart';
import 'package:beer_barrel/navigator/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

DeviceType deviceType = DeviceType.mobile;

enum DeviceType { web_mobile, web_desktop, mobile, ipad, desktop }

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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

_setOrientation() {
  // Lock orientation for most parts of the app
  print("Device Type: $deviceType");
  if (deviceType == DeviceType.ipad) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
    );
  } else {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
      ],
    );
  }
}
