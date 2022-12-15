import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app.dart';

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        print("BlocListener: AppState changed!");
      },
      child: MaterialApp.router(
        routerConfig: goRouter(context),
        debugShowCheckedModeBanner: false,
        restorationScopeId: 'app',
        title: 'Lavoratori Stagionali',
      ),
    );
  }
}
