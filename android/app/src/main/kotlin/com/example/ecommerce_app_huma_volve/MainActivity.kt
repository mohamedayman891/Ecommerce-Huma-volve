package com.example.ecommerce_app_huma_volve

import android.content.ActivityNotFoundException
import android.content.Intent
import android.net.Uri
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "ecommerce_app_huma_volve/whatsapp"
        ).setMethodCallHandler { call, result ->
            if (call.method != "shareToWhatsApp") {
                result.notImplemented()
                return@setMethodCallHandler
            }

            val text = call.argument<String>("text")
            if (text.isNullOrBlank()) {
                result.error("invalid_text", "Share text is required", null)
                return@setMethodCallHandler
            }

            val shareUri = Uri.parse("https://wa.me/?text=${Uri.encode(text)}")
            try {
                startActivity(Intent(Intent.ACTION_VIEW, shareUri))
                result.success(null)
            } catch (error: ActivityNotFoundException) {
                result.error("whatsapp_unavailable", "No app can open WhatsApp links", null)
            }
        }
    }
}
