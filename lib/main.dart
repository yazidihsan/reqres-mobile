import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'app.dart';
import 'sl.dart' as sl;

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await sl.init();
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MainApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
