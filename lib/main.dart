import 'package:ecommerce_app_huma_volve/core/di/di.dart';
import 'package:ecommerce_app_huma_volve/core/deep_link/product_link_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'core/utils/theme.dart';
import 'features/details/screens/product_details_screen.dart';
import 'features/splash/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
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
      onGenerateInitialRoutes: (initialRouteName) {
        final productId = ProductLinkConfig.productIdFromRoute(
          initialRouteName,
        );
        if (productId != null) return [_productRoute(productId)];
        return [_splashRoute()];
      },
      onGenerateRoute: (settings) {
        final productId = ProductLinkConfig.productIdFromRoute(settings.name);
        if (productId != null) return _productRoute(productId);
        if (settings.name == Navigator.defaultRouteName) return _splashRoute();
        return null;
      },
    );
  }

  Route<void> _splashRoute() => MaterialPageRoute<void>(
    settings: const RouteSettings(name: Navigator.defaultRouteName),
    builder: (_) => const SplashScreen(),
  );

  Route<void> _productRoute(String productId) => MaterialPageRoute<void>(
    settings: RouteSettings(name: '/products/$productId'),
    builder: (_) => ProductDetailsScreen.fromId(productId: productId),
  );
}

// I added clean Architecture from start of the project
