import 'package:flutter/material.dart';
import 'package:tree_secure/screens/stripe_pay/webview_stripe.dart';

class VisitedTrees extends StatefulWidget {
  @override
  _VisitedTreesState createState() => _VisitedTreesState();
}

class _VisitedTreesState extends State<VisitedTrees>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: WebviewStripe(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
