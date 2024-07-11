import 'dart:ui';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ValueManager {
  static String? baseUrl = dotenv.env['BASE_URL'];

  static void customToast(String message, {Color? backgroundColor}) =>
      Fluttertoast.cancel().then((value) async => await Fluttertoast.showToast(
          msg: message, toastLength: Toast.LENGTH_LONG));
}
