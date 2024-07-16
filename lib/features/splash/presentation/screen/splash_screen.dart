import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reqres/common_widget/custom_bg_page.dart';
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
        final token = sl<SharedPref>().getAccessToken();

        // log("token : $token");

        if (token != null) {
          GoRouter.of(context).pushReplacementNamed('profile');
        } else {
          GoRouter.of(context).pushReplacementNamed('login');
        }
      },
    );
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
          CustomBackgroundPage(
            isPrimary: true,
            child: Column(
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
          ),
        ],
      ),
    );
  }
}
