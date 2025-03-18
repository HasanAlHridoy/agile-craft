class SigninParams {
  final String userNameOrEmailAddress;
  final String password;

  SigninParams({required this.userNameOrEmailAddress, required this.password});

  Map<String, dynamic> toJson() {
    return {_Json.email: userNameOrEmailAddress, _Json.password: password};
  }
}

class _Json {
  static const email = 'userNameOrEmailAddress';
  static const password = 'password';
}
