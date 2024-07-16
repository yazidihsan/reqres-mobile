import 'package:flutter/widgets.dart';

import 'package:go_router/go_router.dart';
import 'package:reqres/features/auth/presentation/screen/login_screen.dart';
import 'package:reqres/features/auth/presentation/screen/register_screen.dart';
import 'package:reqres/features/main/screen/main_screen.dart';
import 'package:reqres/features/profile/domain/entities/user.dart';
import 'package:reqres/features/profile/presentation/interest_screen.dart';
import 'package:reqres/features/profile/presentation/profile_screen.dart';
import 'package:reqres/features/splash/presentation/screen/splash_screen.dart';

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
    initialLocation: '/splash',
    routes: [
      GoRoute(
          path: '/splash',
          name: 'splash',
          pageBuilder: (context, state) =>
              _buildPageWithDefaultTransition(child: const SplashScreen()),
          routes: [
            GoRoute(
                path: 'login',
                name: 'login',
                pageBuilder: (context, state) =>
                    _buildPageWithDefaultTransition(
                        child: const LoginScreen())),
            GoRoute(
                path: 'register',
                name: 'register',
                pageBuilder: (context, state) =>
                    _buildPageWithDefaultTransition(
                        child: const RegisterScreen())),
          ]),
      GoRoute(
          path: '/profile',
          name: 'profile',
          pageBuilder: (context, state) => _buildPageWithDefaultTransition(
                  child: ProfileScreen(
                interests: state.extra as List<String>?,
              )),
          routes: [
            // GoRoute(
            //     path: 'profile',
            //     name: 'profile',
            //     pageBuilder: (context, state) =>
            //         _buildPageWithDefaultTransition(
            //             child: ProfileScreen(
            //           interests: state.extra as List<String>?,
            //         ))),
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
