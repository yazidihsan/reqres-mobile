import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../sl.dart';
import '../../../../theme_manager/asset_manager.dart';
import '../../../../utils/shared_pref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashScreenHandler();
  }

  splashScreenHandler() {
    Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        goApp();
      },
    );
  }

  goApp() async {
    final pref = sl<SharedPref>();
    pref.sharedPreferences.reload();
    final token = sl<SharedPref>().getAccessToken();

    if (token != null) {
      GoRouter.of(context).goNamed('profile');
    } else {
      GoRouter.of(context).goNamed('login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.black.withOpacity(0.8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.5, 1],
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetManager.iconApp,
                      width: 120,
                      height: 150,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
