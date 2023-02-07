import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavoratori_stagionali/app/app.dart';

import '../cubit/auth_cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            if (state.status == AppStatus.loading) {
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return Container(
                      color: Colors.transparent,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    );
                  });
            }
          },
        ),
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.status == FormStatus.submissionFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text(state.errorMessage!),
                  // backgroundColor: Theme.of(context).colorScheme.primary,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(milliseconds: 5000),
                ));
            }
          },
        )
      ],
      child: SingleChildScrollView(
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
            const SizedBox(height: 16),
            const _EmailInput(),
            const SizedBox(height: 8),
            const _PasswordInput(),
            const SizedBox(height: 8),
            const _LoginButton(),
          ],
        ),
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
          decoration: InputDecoration(
              labelText: "Email",
              helperText: '',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
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
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
            onPressed: (state.status == FormStatus.valid)
                ? () => context.read<AuthCubit>().loginWithCredentials()
                : null,
            child: const Text("Login"));
      },
    );
  }
}
