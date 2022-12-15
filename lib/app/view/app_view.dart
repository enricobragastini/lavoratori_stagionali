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
    );
  }
}
