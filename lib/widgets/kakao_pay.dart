import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funsunfront/services/api_remit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'dart:io' show Platform;

class KakaoPay extends StatelessWidget {
  const KakaoPay({Key? key, required this.url, required this.uid})
      : super(key: key);
  final String url;
  final String uid;

// Flutter 코드 내에서 네이티브 코드로 메시지를 보내는 함수 정의

  @override
  Widget build(BuildContext context) {
    Future<String> getAppUrl(String url) async {
      const platform = MethodChannel('kakaopay');
      return await platform
          .invokeMethod('getAppUrl', <String, Object>{'url': url});
    }

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    if (Platform.isAndroid) {
      if (controller.platform is AndroidWebViewController) {
        AndroidWebViewController.enableDebugging(true);
        (controller.platform as AndroidWebViewController)
            .setMediaPlaybackRequiresUserGesture(false);
        controller.setNavigationDelegate(NavigationDelegate(
          onNavigationRequest: (request) async {
            print(request.url);
            Uri uriParsed = Uri.parse(request.url);
            if (uriParsed.scheme == 'intent') {
              getAppUrl(request.url).then((value) async {
                try {
                  await launchUrl(Uri.parse(value),
                      mode: LaunchMode.externalApplication);
                } on PlatformException {
                  Navigator.pop(context,
                      {'result': false, 'message': '카카오톡이 설치되어 있지 않습니다.'});
                } on Exception {
                  Navigator.pop(
                      context, {'result': false, 'message': '알 수 없는 오류 발생.'});
                }
              });

              return NavigationDecision.prevent;
            }
            if (request.url.contains('projectsekai')) {
              final pgToken = request.url.split('pg_token=')[1];
              final bool res =
                  await Remit.postPayApprove(userid: uid, pgToken: pgToken);
              if (context.mounted) {
                Navigator.pop(context, {'result': res, 'message': '200'});
              }
            }
            return NavigationDecision.navigate;
          },
        ));
      }
      // Android-specific code
    } else if (Platform.isIOS) {
      // iOS-specific code

      controller.setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) async {
          if (request.url.contains('projectsekai')) {
            final pgToken = request.url.split('pg_token=')[1];
            final bool res =
                await Remit.postPayApprove(userid: uid, pgToken: pgToken);
            if (context.mounted) {
              Navigator.pop(context, {'result': res, 'message': '200'});
            }
          }
          return NavigationDecision.navigate;
        },
      ));
    }

    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.loadRequest(Uri.parse(url));

    return WebViewWidget(controller: controller);
  }
}
