import 'package:flutter/material.dart';
import 'package:minha_biblioteca_fase_9/features/authentication/views/login/login.page.dart';
import 'package:minha_biblioteca_fase_9/features/categories/views/categories/category.page.dart';
import 'package:minha_biblioteca_fase_9/features/splash_screen/view/splash.store.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final splashStore = SplashStore();

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final isAuthenticated = await splashStore.userIsAuthenticated();
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) {
            return isAuthenticated ? CategoryPage() : const LoginPage();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
