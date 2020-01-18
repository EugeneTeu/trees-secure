import 'package:flutter/material.dart';
import 'package:tree_secure/screens/stripe_pay/stripe_pay.dart';

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
      child: StripePay(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
