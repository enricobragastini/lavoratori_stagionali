import 'package:flutter/material.dart';

import '../app.dart';

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter(context),
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      title: 'Lavoratori Stagionali',
      theme: ThemeData(
          // Define the default brightness and colors.
          textTheme: Theme.of(context).textTheme.apply(fontSizeFactor: 1.1),
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(primary: const Color(0xFF4059AD))),
    );
  }
}
