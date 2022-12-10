import 'package:flutter/material.dart';
import 'package:lavoratori_stagionali/src/routing/app_router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      title: 'Lavoratori Stagionali',
    );
  }
}
