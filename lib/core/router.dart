import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common/role_selection_screen.dart';
import '../common/splash_screen.dart';
import 'user_role.dart';

abstract final class RouteNames {
  static const splash = '/';
  static const roleSelection = '/role-selection';
  static const login = '/login';
}

final appRouter = GoRouter(
  initialLocation: RouteNames.splash,
  routes: [
    GoRoute(
      path: RouteNames.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteNames.roleSelection,
      builder: (context, state) => const RoleSelectionScreen(),
    ),
    // TODO: replace with LoginScreen once it is built.
    GoRoute(
      path: RouteNames.login,
      builder: (context, state) {
        final role = state.extra as UserRole?;
        return Scaffold(
          appBar: AppBar(),
          body: Center(child: Text('Login — ${role?.title ?? 'no role'}')),
        );
      },
    ),
  ],
);
