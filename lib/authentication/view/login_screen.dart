import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavoratori_stagionali/authentication/cubit/auth_cubit.dart';
import 'package:lavoratori_stagionali/authentication/view/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key, required this.authenticationRepository})
      : super(key: key);

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 200),
            child: BlocProvider(
              create: (context) =>
                  AuthCubit(authenticationRepository: authenticationRepository),
              child: const LoginForm(),
            ),
          ),
        ),
      ),
    );
  }
}
