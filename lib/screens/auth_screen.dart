import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formkey = GlobalKey<FormState>();

  void _tryLogin() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Form(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/firechat.png',
                      width: 80,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (!EmailValidator.validate(value!))
                          return 'Please Enter a Valid Email';
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value!.isEmpty) return 'Please Enter Username';
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Password'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7)
                          return 'Password must be at least 7 characters long';
                      },
                    ),
                    SizedBox(height: 12),
                    RaisedButton(
                      child: Text('Login'),
                      onPressed: () {},
                    ),
                    FlatButton(
                      child: Text('SignUp'),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
