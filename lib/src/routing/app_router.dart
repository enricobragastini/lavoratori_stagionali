import 'package:go_router/go_router.dart';
import 'package:lavoratori_stagionali/src/authentication/view/login_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);
