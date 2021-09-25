import 'dart:io';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/profile_pic.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formkey = GlobalKey<FormState>();
  var _isLoading = false;
  bool _isLogin = true;
  String _email = '';
  String _password = '';
  String _username = '';
  File? _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _submitAuthForm(BuildContext con) async {
    var authresult;
    final _auth = FirebaseAuth.instanceFor(app: await Firebase.initializeApp());
    try {
      setState(() {
        _isLoading = true;
      });
      if (_isLogin) {
        authresult = await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
      } else {
        authresult = await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
      }
      if (!_isLogin) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('images')
            .child(authresult.user.uid + '.jpg');

        await ref.putFile(_userImageFile!);
        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authresult.user.uid)
            .set({
          'username': _username,
          'url': url,
        });
      }
    } on FirebaseException catch (err) {
      ScaffoldMessenger.of(con).showSnackBar(SnackBar(
        content: Text(err.message!),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _tryLogin(BuildContext context) {
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please provide a Profile Picture'),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      );
      return;
    }
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      _submitAuthForm(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(30),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    if (_isLogin)
                      Image.asset(
                        'assets/firechat.png',
                        width: 80,
                      ),
                    if (!_isLogin) ProfilePic(_pickedImage),
                    if (!_isLogin)
                      TextFormField(
                        autocorrect: true,
                        textCapitalization: TextCapitalization.words,
                        enableSuggestions: false,
                        key: ValueKey('username'),
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(labelText: 'Username'),
                        validator: (value) {
                          if (value!.isEmpty) return 'Please Enter Username';
                        },
                        onSaved: (value) {
                          _username = value!.trim();
                        },
                      ),
                    TextFormField(
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      key: ValueKey('email'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (!EmailValidator.validate(value!.trim()))
                          return 'Please Enter a Valid Email';
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!.trim();
                      },
                    ),
                    TextFormField(
                      key: ValueKey('password'),
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Password'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7)
                          return 'Password must be at least 7 characters long';
                      },
                      onSaved: (value) {
                        _password = value!.trim();
                      },
                    ),
                    SizedBox(height: 12),
                    if (_isLoading)
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(),
                      ),
                    if (!_isLoading)
                      ElevatedButton(
                        onPressed: () => _tryLogin(context),
                        style: ButtonStyle(),
                        child: Text(
                          _isLogin ? 'Login' : 'SignUp',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (!_isLoading)
                      TextButton(
                        child: Text(
                          _isLogin ? 'SignUp' : 'LogIn',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              _isLogin = !_isLogin;
                            },
                          );
                        },
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
