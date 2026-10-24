import 'package:ecommerce_app_huma_volve/core/di/di.dart';
import 'package:flutter/material.dart';
import 'core/utils/theme.dart';
import 'features/splash/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const EcommerceHumaVolve());
}

class EcommerceHumaVolve extends StatelessWidget {
  const EcommerceHumaVolve({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}

// I added clean Architecture from start of the project
