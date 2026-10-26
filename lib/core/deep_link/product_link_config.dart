class ProductLinkConfig {
  // Set the same Firebase Hosting host with --dart-define at build time.
  static const hostingDomain = String.fromEnvironment(
    'FIREBASE_HOSTING_DOMAIN',
    defaultValue: 'your-project-id.web.app',
  );

  static bool get isConfigured => hostingDomain != 'your-project-id.web.app';

  static Uri productUri(String productId) => Uri.https(
    hostingDomain,
    '/products/${Uri.encodeComponent(productId)}',
  );

  static String? productIdFromRoute(String? routeName) {
    if (routeName == null || routeName.isEmpty) return null;
    final uri = Uri.tryParse(routeName);
    if (uri == null) return null;
    final segments = uri.pathSegments;
    if (segments.length != 2 || segments.first != 'products') return null;
    final id = segments[1].trim();
    return id.isEmpty ? null : id;
  }
}
