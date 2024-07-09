import 'package:flutter_dotenv/flutter_dotenv.dart';

class ValueManager {
  static String? baseUrl = dotenv.env['BASE_URL'];
}
