import 'dart:io';

import 'package:chat/models/auth_data.dart';
import 'package:chat/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm(this.onSubmit);

  final void Function(AuthData authData) onSubmit;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthData _authData = AuthData();

  _submit() {
    bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_authData.image == null && _authData.isSignup) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Need your photo for the sign up"),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (isValid) {
      widget.onSubmit(_authData);
    }
  }

  void _handlePickedImage(File image) {
    _authData.image = image;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (_authData.isSignup) UserImagePicker(_handlePickedImage),
                    if (_authData.isSignup)
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Name'),
                        onChanged: (value) => _authData.name = value,
                        validator: (value) {
                          if (value == null || value.trim().length < 4) {
                            return 'Nome deve ter no minimo 4 caracteres';
                          }
                        },
                        initialValue: _authData.name,
                        key: ValueKey('name'),
                      ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      onChanged: (value) => _authData.email = value,
                      validator: (value) {
                        if (value == null || !value.contains('@')) {
                          return 'E-mail inválido';
                        }
                      },
                      key: ValueKey('email'),
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                      ),
                      onChanged: (value) => _authData.password = value,
                      validator: (value) {
                        if (value == null || value.trim().length < 7) {
                          return 'Senha deve ter no minimo 7 caracteres';
                        }
                      },
                      key: ValueKey('password'),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _submit,
                      child: Text(_authData.isLogin ? 'Login' : 'Sign up'),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            primary: Theme.of(context).primaryColor),
                        onPressed: () {
                          setState(() {
                            _authData.toggleMode();
                          });
                        },
                        child: Text(_authData.isLogin
                            ? 'Create a new account'
                            : 'Already have an account ?'))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
