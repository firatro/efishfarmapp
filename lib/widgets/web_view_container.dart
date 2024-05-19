import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({super.key});

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {

  final controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.disabled)
  ..loadRequest(Uri.parse("https://agriculture.einnews.com/pr_news/683177170/5-major-aquaculture-market-size-is-set-to-reach-87-6-billion-blue-ridge-aquaculture-huon-aquaculture-eastern-fish"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("WebViewContainer"),),
      body: WebViewWidget(controller: controller),
    );
  }
}