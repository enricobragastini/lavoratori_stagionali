import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:lavoratori_stagionali/app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Lavoratori Stagionali');
    setWindowMinSize(const Size(1100, 700));
  }

  AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

  runApp(
    BlocProvider(
      create: (context) =>
          AppBloc(authenticationRepository: authenticationRepository),
      child: const AppView(),
    ),
  );
}
