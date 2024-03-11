import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'colors.dart';
import 'features/splash_screen/view/splash_screen.page.dart';
import 'shared/utils/constants.dart';

void initServiceLocator() {
  GetIt.I.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: Constants.baseApiUrl)),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Biblioteca',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: getMaterialColor(primaryColor),
      ),
      home: const SplashScreenPage(),
    );
  }
}
