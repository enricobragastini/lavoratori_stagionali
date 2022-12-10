import 'package:flutter/material.dart';
import 'package:lavoratori_stagionali/src/authentication/view/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 200),
          child: LoginForm(),
        ),
      ),
    );
  }
}
