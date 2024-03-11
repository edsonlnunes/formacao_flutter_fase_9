import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:my_library_app/shared/views/theme.store.dart';
import 'package:my_library_app/themes/theme.dart';

import 'features/authentication/views/login/login.page.dart';
import 'injection_container.dart' as injection_container;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  injection_container.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final themeStore = GetIt.I<ThemeStore>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MaterialApp(
        title: 'Minha Biblioteca',
        debugShowCheckedModeBanner: false,
        themeMode: themeStore.themeMode,
        theme: lightTheme(),
        darkTheme: darkTheme(),
        home: const LoginPage(),
      );
    });
  }
}
