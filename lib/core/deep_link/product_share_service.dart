import 'package:ecommerce_app_huma_volve/core/deep_link/product_link_config.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductShareService {
  static const MethodChannel _channel = MethodChannel(
    'ecommerce_app_huma_volve/whatsapp',
  );

  static Future<void> shareProduct(BuildContext context, Product product) async {
    final id = product.id;
    if (id == null || id.isEmpty) return;

    final title = product.title?.trim().isNotEmpty == true
        ? product.title!.trim()
        : 'Product';
    final price = product.price == null ? '' : '\nPrice: \$${product.price}';
    final productLink = ProductLinkConfig.isConfigured
        ? '\n${ProductLinkConfig.productUri(id)}'
        : '';
    final message = '$title$price$productLink';
    try {
      if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
        await _channel.invokeMethod<void>('shareToWhatsApp', {'text': message});
      } else {
        await Clipboard.setData(ClipboardData(text: message));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product link copied')),
          );
        }
      }
    } on PlatformException {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open WhatsApp')),
      );
    }
  }
}
