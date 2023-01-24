import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:lavoratori_stagionali/app/app.dart';
import 'package:workers_repository/workers_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Lavoratori Stagionali');
    setWindowMinSize(const Size(1100, 700));
  }

  AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

  WorkersRepository workersRepository = WorkersRepository();

  runApp(
    BlocProvider(
      create: (context) => AppBloc(
          authenticationRepository: authenticationRepository,
          workersRepository: workersRepository),
      child: const AppView(),
    ),
  );
}
