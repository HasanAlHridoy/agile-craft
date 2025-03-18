import 'package:agile_crafts_task/src/core/config/size/size.dart';
import 'package:agile_crafts_task/src/core/utils/extensions/context.dart';
import 'package:agile_crafts_task/src/core/utils/extensions/double.dart';
import 'package:agile_crafts_task/src/features/sign_in/controller/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignInView extends ConsumerWidget {
  const SignInView({super.key});

  static const String name = 'signin';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(signinProvider);
    final notifier = ref.read(signinProvider.notifier);
    return Scaffold(
      body: Form(
        key: notifier.signinFormKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Login', style: context.text.displaySmall),
                  (defaultPadding * 5).height,
                  TextFormField(
                    style: context.text.bodyMedium!,
                    controller: notifier.emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: context.text.bodyMedium!.copyWith(color: context.theme.dividerColor),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (v) => v == null || v.isEmpty ? 'email address or user name is required' : null,
                    onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                  (defaultPadding).height,
                  TextFormField(
                    controller: notifier.passwordController,
                    style: context.text.bodyMedium,
                    obscureText: notifier.obscureText,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      hintStyle: context.text.bodyMedium!.copyWith(color: context.theme.dividerColor),
                      suffixIcon: IconButton(
                        icon: Icon(notifier.obscureText ? Icons.visibility_off : Icons.visibility),
                        onPressed: notifier.toggleObscureText,
                        iconSize: 20,
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    autofillHints: const [AutofillHints.password],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (v) => v!.isEmpty ? 'Password is required' : null,
                    onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                  (defaultPadding * 2).height,
                  ElevatedButton(
                    onPressed:
                        notifier.isLoading
                            ? null
                            : () async {
                              await notifier.signin(context);
                              //  context.go(AppRoutes.branchesRoute);
                            },
                    child:
                        notifier.isLoading
                            ? SpinKitThreeBounce(color: context.theme.primaryColor, size: 20)
                            : const Text("Login"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
