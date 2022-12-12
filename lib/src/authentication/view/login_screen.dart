import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavoratori_stagionali/src/authentication/cubit/auth_cubit.dart';
import 'package:lavoratori_stagionali/src/authentication/view/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 200),
          child: BlocProvider(
            create: (context) =>
                AuthCubit(authenticationRepository: AuthenticationRepository()),
            child: const LoginForm(),
          ),
        ),
      ),
    );
  }
}
