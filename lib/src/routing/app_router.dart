import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lavoratori_stagionali/src/authentication/cubit/auth_cubit.dart';
import 'package:lavoratori_stagionali/src/authentication/view/login_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BlocProvider(
        create: (context) => AuthCubit(),
        child: const LoginScreen(),
      ),
    )
  ],
);
