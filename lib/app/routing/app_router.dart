import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lavoratori_stagionali/app/routing/go_router_refresh_stream.dart';

import 'package:lavoratori_stagionali/authentication/view/login_screen.dart';
import 'package:lavoratori_stagionali/home/view/view.dart';
import '../app.dart';

GoRouter goRouter(BuildContext context) {
  return GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => LoginScreen(
            authenticationRepository:
                BlocProvider.of<AppBloc>(context).authenticationRepository,
          ),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        )
      ],
      redirect: ((context, state) {
        switch (BlocProvider.of<AppBloc>(context).state.status) {
          case AuthenticationStatus.authenticated:
            return '/';
          case AuthenticationStatus.unauthenticated:
            return '/login';
          case AuthenticationStatus.unknown:
            return '/login';
        }
      }),
      refreshListenable:
          GoRouterRefreshStream(BlocProvider.of<AppBloc>(context).stream));
}
