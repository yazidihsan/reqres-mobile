import 'package:flutter/material.dart';

import 'color_manager.dart';

ThemeData getApplicationThemeData(BuildContext context) => ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorManager.bg5,
        surfaceTint: Colors.transparent,
      ),
    );
