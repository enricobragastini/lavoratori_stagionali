import 'dart:io';

import 'package:appwrite_api/appwrite_api.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:lavoratori_stagionali/app/app.dart';
import 'package:lavoratori_stagionali/network/bloc/network_bloc.dart';
import 'package:workers_repository/workers_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      setWindowTitle('Lavoratori Stagionali');
      setWindowMinSize(const Size(1100, 900));
    }
    // ignore: empty_catches
  } catch (e) {}

  AppwriteAPI appwriteAPI = AppwriteAPI();

  AuthenticationRepository authenticationRepository =
      AuthenticationRepository(appwriteAPI: appwriteAPI);

  WorkersRepository workersRepository =
      WorkersRepository(appwriteAPI: appwriteAPI);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppBloc(
              authenticationRepository: authenticationRepository,
              workersRepository: workersRepository),
        ),
        BlocProvider(
          create: (context) => NetworkBloc()..observeNetwork(),
        )
      ],
      child: const AppView(),
    ),
  );
}
