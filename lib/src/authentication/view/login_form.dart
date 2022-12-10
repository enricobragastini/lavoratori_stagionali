import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 150,
          ),
          const SizedBox(height: 16),
          const Text(
            "LOGIN",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const _EmailInput(),
          const SizedBox(height: 8),
          const _PasswordInput(),
          const SizedBox(height: 8),
          const _LoginButton(),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(labelText: "Email", helperText: ''),
          onChanged: (email) => context.read<AuthCubit>().emailChanged(email),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return TextField(
          obscureText: !state.passwordVisibility,
          onChanged: (pwd) => context.read<AuthCubit>().passwordChanged(pwd),
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
              labelText: "Password",
              helperText: '',
              suffixIcon: IconButton(
                icon: Icon(state.passwordVisibility
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: () =>
                    context.read<AuthCubit>().passwordVisibilityChanged(),
              )),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: const Text("Login"));
  }
}
