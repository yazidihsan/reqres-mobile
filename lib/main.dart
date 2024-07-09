import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'sl.dart' as sl;

Future<void> main() async {
  await dotenv.load();
  await sl.init();

  runApp(const MainApp());
}
