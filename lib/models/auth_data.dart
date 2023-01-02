enum AuthMode {
  LOGIN,
  SINGUP,
}

class AuthData {
  String? name;
  String? email;
  String? password;
  AuthMode _mode = AuthMode.LOGIN;

  bool get isSignup {
    return _mode == AuthMode.SINGUP;
  }

  bool get isLogin {
    return _mode == AuthMode.LOGIN;
  }

  void toggleMode() {
    _mode = _mode == AuthMode.LOGIN ? AuthMode.SINGUP : AuthMode.LOGIN;
  }
}
