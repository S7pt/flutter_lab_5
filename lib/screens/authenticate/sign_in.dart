import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:to_do_list/components/spinner.dart';
import 'package:to_do_list/components/textbox.dart';
import 'package:to_do_list/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function switchScreen;
  SignIn({required this.switchScreen});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService? _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Spinner();
    } else {
      return Scaffold(
        backgroundColor: Colors.cyan[100],
        appBar: AppBar(
          backgroundColor: Colors.cyan[400],
          elevation: 0.0,
          title: const Text('Log in'),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.cyan[400],
                onPrimary: Colors.white,
              ),
              child: const Text("Sign up"),
              onPressed: () {
                widget.switchScreen();
              },
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInput.copyWith(hintText: "Email"),
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInput.copyWith(hintText: "Password"),
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                  validator: (val) => val!.length < 6
                      ? 'Enter a password with a length of a 6+ characters'
                      : null,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey[400],
                    onPrimary: Colors.white,
                  ),
                  child: const Text(
                    "Sign in",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      dynamic result = await _auth?.loginWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() {
                          error = 'wrong credentials, please try again';
                          isLoading = false;
                        });
                      }
                    }
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
