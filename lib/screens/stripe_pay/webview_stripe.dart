import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStripe extends StatefulWidget {
  @override
  _WebViewStripeState createState() {
    // TODO: implement createState
    return _WebViewStripeState();
  }
}

class _WebViewStripeState extends State<WebViewStripe> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  final Set<String> _favorites = Set<String>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3 * 2,
      width: 500,
      child: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:
            Uri.dataFromString("stripe url", mimeType: 'text/html').toString(),
        onWebViewCreated: (WebViewController webViewController) {
          print("completed");
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
