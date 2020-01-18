import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewStripe extends StatefulWidget {
  @override
  _WebviewStripeState createState() {
    // TODO: implement createState
    return _WebviewStripeState();
  }
}

class _WebviewStripeState extends State<WebviewStripe> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: rootBundle.loadString('assets/stripe_checkout.html'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return WebView(
              initialUrl: new Uri.dataFromString(snapshot.data,
                      mimeType: 'text/html')
                  .toString(), // maybe you Uri.dataFromString(snapshot.data, mimeType: 'text/html', encoding: Encoding.getByName("UTF-8")).toString()
              javascriptMode: JavascriptMode.unrestricted,
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        });
  }
}
