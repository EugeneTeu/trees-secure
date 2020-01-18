import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DiscoverTrees extends StatefulWidget {
  @override
  _DiscoverTreesState createState() => _DiscoverTreesState();
}

class _DiscoverTreesState extends State<DiscoverTrees>
    with AutomaticKeepAliveClientMixin {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  final Set<String> _favorites = Set<String>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("DISCOVER TREES"),
            Container(
              height: 500,
              width: 500,
              child: WebView(
                initialUrl: 'https://en.wikipedia.org/wiki/Kraken',
                onWebViewCreated: (WebViewController webViewController) {
                  print("completed");
                  _controller.complete(webViewController);
                },
              ),
            )
          ],
        ),
      )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
