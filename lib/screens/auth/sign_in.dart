import 'package:flutter/material.dart';

import 'package:tree_secure/services/auth_service.dart';
import 'package:tree_secure/shared/loading_spinner.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn(this.toggleView);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
                  enabled: !isLoading,
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
                  enabled: !isLoading,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (val) => val.length < 6
                      ? 'Please enter your valid password'
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
                                await _auth.signInWithEmailAndPassword(
                                    email, password);
                              } catch (err) {
                                print(err);
                                String displayMsg =
                                    'An unknown error occurred. Please try again later.';
                                if (err.code == 'ERROR_INVALID_EMAIL') {
                                  displayMsg =
                                      'The email you have entered is invalid.';
                                } else if (err.code == 'ERROR_USER_NOT_FOUND' ||
                                    err.code == 'ERROR_WRONG_PASSWORD') {
                                  displayMsg =
                                      'This user does not exist, or the password you have entered may be wrong.';
                                } else if (err.code ==
                                    'ERROR_TOO_MANY_REQUESTS') {
                                  displayMsg =
                                      'Too many unsuccessful login attempts detected from your device. Please try again after a few minutes.';
                                }
                                setState(() => this.isLoading = false);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Failed to Sign In'),
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
                            'Sign In',
                            style: TextStyle(),
                          ),
                  ),
                ),
                FlatButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          widget.toggleView();
                        },
                  child: Text(
                    'Don\'t have an account yet?',
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SocialAuthButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Color color;
  final Function onPressed;

  SocialAuthButton({this.icon, this.label, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      onPressed: this.onPressed,
      color: this.color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              right: 10,
            ),
            child: this.icon,
          ),
          Text(
            label,
          ),
          SizedBox(
            width: 0,
          ),
        ],
      ),
    );
  }
}
