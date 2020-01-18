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
              height: MediaQuery.of(context).size.height / 3 * 2,
              width: 500,
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: Uri.dataFromString(
                        '<html><body><iframe width="${MediaQuery.of(context).size.width * 3}" height="${MediaQuery.of(context).size.height * 2}" src="https://data.gov.sg/dataset/heritage-trees/resource/07df4d4c-274e-4b3a-af1d-7f79e43800d4/view/36d40023-2329-4a1f-9ea7-b49a680bc227" frameBorder="0"> </iframe></body></html>',
                        mimeType: 'text/html')
                    .toString(),
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
