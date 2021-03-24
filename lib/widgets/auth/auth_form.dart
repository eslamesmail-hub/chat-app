import 'dart:io';
import 'package:chat_app/widgets/picker/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username,
      File image, bool isLogin, BuildContext ctx) submitFunction;
  final bool isLoading;
  AuthForm(this.submitFunction, this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = '';
  String _password = '';
  String _username = '';
  File _userImageFile;

  void _pickedImage(File pickedImage) {
    _userImageFile = pickedImage;
  }

  void _submit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (!_isLogin && _userImageFile == null) {
      Scaffold.of(context)
          // ignore: deprecated_member_use
          .showSnackBar(
        SnackBar(
          content: Text('Please pick an image'),
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFunction(
        _email.trim(),
        _password.trim(),
        _username.trim(),
        _userImageFile,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isLogin) UserImagePicker(_pickedImage),
                TextFormField(
                  autocorrect: false,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.none,
                  key: ValueKey('email'),
                  validator: (val) {
                    if (val.isEmpty || !val.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onSaved: (val) => _email = val,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email Address'),
                ),
                if (!_isLogin)
                  TextFormField(
                    autocorrect: true,
                    enableSuggestions: false,
                    textCapitalization: TextCapitalization.words,
                    key: ValueKey('username'),
                    validator: (val) {
                      if (val.isEmpty || val.length < 4) {
                        return 'Please enter at least 4 characters';
                      }
                      return null;
                    },
                    onSaved: (val) => _username = val,
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (val) {
                    if (val.isEmpty || val.length < 7) {
                      return 'Please enter at least 7 characters';
                    }
                    return null;
                  },
                  onSaved: (val) => _password = val,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 12),
                if (widget.isLoading)
                  Center(
                    child: Text('Loading...'),
                  ),
                if (!widget.isLoading)
                  // ignore: deprecated_member_use
                  RaisedButton(
                    onPressed: _submit,
                    child: Text(
                      _isLogin ? 'Login' : 'Sign up',
                    ),
                  ),
                if (!widget.isLoading)
                  // ignore: deprecated_member_use
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(
                      _isLogin
                          ? 'Create new account'
                          : 'I already have an account',
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
