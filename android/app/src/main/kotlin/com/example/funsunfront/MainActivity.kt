package com.example.funsunfront

import android.content.ActivityNotFoundException
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "kakaopay"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        handleIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleIntent(intent)
    }

    private fun handleIntent(intent: Intent?) {
        if (intent?.action == Intent.ACTION_VIEW) {
            val uri: Uri? = intent.data
            if (uri != null) {
                val intentData = uri.toString()
                // Handle the intent data as needed, for example, extract parameters from the URI
                // and perform specific actions based on the parameters.

                // Send the intent data back to Flutter for further processing if required.
                MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger as BinaryMessenger, CHANNEL)
                    .invokeMethod("handleIntentLink", intentData)
            }
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger as BinaryMessenger, CHANNEL)
            .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                when (call.method) {
                    "getAppUrl" -> {
                        val url: String? = call.argument("url")
                        Log.i("url", url ?: "")
                        val intent = Intent.parseUri(url, Intent.URI_INTENT_SCHEME)

                        result.success(intent.dataString)
                    }
                    else -> result.notImplemented()
                }
            }
    }
}
