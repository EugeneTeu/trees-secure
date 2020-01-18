import 'package:flutter/material.dart';

import 'package:tree_secure/services/auth_service.dart';
import 'package:tree_secure/shared/loading_spinner.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register(this.toggleView);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  // user email/pw input
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: IntrinsicHeight(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (val) =>
                      val.isEmpty ? 'Please enter your email' : null,
                  onChanged: (val) {
                    setState(() => this.email = val);
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (val) => val.length < 6
                      ? 'Your password should contain at least 6 characters'
                      : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => this.password = val);
                  },
                ),
                SizedBox(height: 10),
                IntrinsicWidth(
                  child: RaisedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => this.isLoading = true);
                              try {
                                await _auth.createUserWithEmailAndPassword(
                                    email, password);
                              } catch (err) {
                                String displayMsg =
                                    'An unknown error occurred. Please try again later.';
                                if (err.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
                                  displayMsg =
                                      'Sorry, this email is already registered. Please use another email instead.';
                                } else if (err.code == 'ERROR_INVALID_EMAIL') {
                                  displayMsg = 'Please enter a valid email.';
                                }
                                setState(() => this.isLoading = false);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Failed to Register'),
                                      content: Text(displayMsg),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          },
                    child: isLoading
                        ? Container(
                            child: LoadingSpinner(),
                          )
                        : Text(
                            'Register',
                            style: TextStyle(),
                          ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    widget.toggleView();
                  },
                  child: Text(
                    'Already have an account?',
                    style: Theme.of(context).textTheme.body2,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
