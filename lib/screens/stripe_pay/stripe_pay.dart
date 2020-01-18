import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'dart:io';
import 'dart:convert';

class StripePay extends StatefulWidget {
  @override
  _StripePayState createState() => _StripePayState();
}

class _StripePayState extends State<StripePay> {
  Token _paymentToken;
  PaymentMethod _paymentMethod;
  String _error;
  final String _currentSecret = null; //set this yourself, e.g using curl
  PaymentIntentResult _paymentIntent;
  Source _source;

  final CreditCard testCard = CreditCard(
    number: '4000002760003184',
    expMonth: 12,
    expYear: 21,
  );

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    StripePayment.setOptions(StripeOptions(
      publishableKey: "pk_test_dG8jwYAvUaOFvA16m0zOqzKw00yOJ3QBCw",
      merchantId: "Test",
      androidPayMode: 'test',
    ));
  }

  void setError(dynamic error) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          width: 300,
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  StripePayment.createSourceWithParams(SourceParams(
                    type: 'ideal',
                    amount: 1099,
                    currency: 'eur',
                    returnURL: 'example://stripe-redirect',
                  )).then((source) {
                    _scaffoldKey.currentState.showSnackBar(
                        SnackBar(content: Text('Received ${source.sourceId}')));
                    setState(() {
                      _source = source;
                    });
                  }).catchError(setError);
                },
              ),
              RaisedButton(
                child: Text("Native payment"),
                onPressed: () {
                  StripePayment.paymentRequestWithNativePay(
                    androidPayOptions: AndroidPayPaymentRequest(
                      total_price: "1.20",
                      currency_code: "EUR",
                    ),
                    applePayOptions: ApplePayPaymentOptions(
                      countryCode: 'DE',
                      currencyCode: 'EUR',
                      items: [
                        ApplePayItem(
                          label: 'Test',
                          amount: '1.00',
                        )
                      ],
                    ),
                  ).then((token) {
                    setState(() {
                      _scaffoldKey.currentState.showSnackBar(
                          SnackBar(content: Text('Received ${token.tokenId}')));
                      _paymentToken = token;
                    });
                  }).catchError(setError);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
