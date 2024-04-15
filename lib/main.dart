import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: WebViewApp(),
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({Key? key}) : super(key: key);

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;
  String status = '';

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://trustshield.my.id/'),
        // Uri.parse('http://localhost:5173/'),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              status = 'Loading (progress : $progress%)';
            });
            print('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            setState(() {
              status = 'Page started loading: $url';
            });
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            setState(() {
              status = 'Page finished loading: $url';
            });
            print('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              status = 'Page resource error: ${error.description}';
            });
            print(''' onWebResourceError: ${error.description}''');
          },
          onNavigationRequest: (NavigationRequest request) {
            setState(() {
              status = 'onNavigationRequest: ${request.url}';
            });
            print('onNavigationRequest');
            return NavigationDecision.navigate;
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
