import 'package:agile_crafts_task/injectors.dart';
import 'package:agile_crafts_task/src/core/router/go_router.dart';
import 'package:agile_crafts_task/src/features/sign_in/model/request/sign_in.dart';
import 'package:agile_crafts_task/src/features/sign_in/repository/signin.dart';

import 'package:agile_crafts_task/src/shared/custom_snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef SigninNotifier = NotifierProvider<AuthProvider, void>;

final signinProvider = SigninNotifier(AuthProvider.new);

class AuthProvider extends Notifier<void> {
  
  final signinFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool obscureText = true;
  @override
  void build() {
    emailController.text = 'samad';
    passwordController.text = '1234';
  }

  void toggleObscureText() {
    obscureText = !obscureText;
    ref.notifyListeners();
  }

  Future<void> signin(BuildContext context) async {
    if (!(signinFormKey.currentState?.validate() ?? false)) return;
    isLoading = true;
    ref.notifyListeners();
    //
    final response = await sl<SignInRepository>().signin(
      params: SigninParams(userNameOrEmailAddress: emailController.text, password: passwordController.text),
    );
    response.fold(
      (error) {
        isLoading = false;
        ref.notifyListeners();
        CustomSnackbar.show(context, error.toString(), isError: true);
      },
      (success) async {
        isLoading = false;
        ref.notifyListeners();
        goRouter.refresh();
      },
    );
  }
}
