import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

import 'package:lavoratori_stagionali/src/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Lavoratori Stagionali');
    setWindowMinSize(const Size(1100, 700));
  }

  runApp(
    const App(),
  );
}
