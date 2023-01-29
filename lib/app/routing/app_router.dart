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
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(
          authenticationRepository:
              BlocProvider.of<AppBloc>(context).authenticationRepository,
        ),
      ),
      GoRoute(
        path: '/home-page',
        builder: (context, state) => HomePage(
          workersRepository:
              BlocProvider.of<AppBloc>(context).workersRepository,
        ),
      )
    ],

    // GoRouter ascolta i cambiamenti di stato in AppBloc
    refreshListenable:
        GoRouterRefreshStream(BlocProvider.of<AppBloc>(context).stream),

    // Se ci sono cambiamenti di stato in AppBloc
    // Valuta lo stato dell'autenticazione e in base a quello fa il redirect sulla pagina adeguata.
    redirect: ((context, state) {
      final status = BlocProvider.of<AppBloc>(context).state.status;
      switch (status) {
        case AuthenticationStatus.authenticated:
          return '/home-page';
        case AuthenticationStatus.unauthenticated:
          return '/login';
      }
    }),
  );
}
