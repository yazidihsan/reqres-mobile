import 'package:flutter/widgets.dart';

import 'package:go_router/go_router.dart';
import 'package:reqres/features/auth/presentation/login_screen.dart';
import 'package:reqres/features/auth/presentation/register_screen.dart';
import 'package:reqres/features/profile/presentation/interest_screen.dart';
import 'package:reqres/features/profile/presentation/profile_screen.dart';

class RoutesService {
  static CustomTransitionPage _buildPageWithDefaultTransition(
          {required Widget child}) =>
      CustomTransitionPage(
        child: child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var tween = Tween(begin: const Offset(1, 0), end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeIn));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );

  static GoRouter goRouter = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
          path: '/login',
          name: 'login',
          pageBuilder: (context, state) =>
              _buildPageWithDefaultTransition(child: const LoginScreen()),
          routes: [
            GoRoute(
                path: 'register',
                name: 'register',
                pageBuilder: (context, state) =>
                    _buildPageWithDefaultTransition(
                        child: const RegisterScreen()))
          ]),
      GoRoute(
          path: '/profile',
          name: 'profile',
          pageBuilder: (context, state) =>
              _buildPageWithDefaultTransition(child: const ProfileScreen()),
          routes: [
            GoRoute(
              path: 'interest',
              name: 'interest',
              pageBuilder: (context, state) => _buildPageWithDefaultTransition(
                  child: const InterestScreen()),
            )
          ])
    ],
  );
}
