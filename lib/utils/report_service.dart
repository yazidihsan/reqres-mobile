import 'dart:convert';

import 'package:http/http.dart' as http;

import '../sl.dart';
import '../theme_manager/value_manager.dart';
import 'shared_pref.dart';

class ReportService {
  final http.Client client;

  ReportService({
    required this.client,
  });

  Future<void> reportError(String message, String location) async {
    final dateTime = DateTime.now().toIso8601String();

    final messageReport =
        jsonEncode({'location': location, 'message': message});

    await client.post(
        Uri.parse('${ValueManager.baseUrl}/api/v1/client-side-log'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'OAuth 2.0'
        },
        body: {
          'datetime': dateTime,
          'type': 'warning',
          'app_name': 'techtest.youapp.ai',
          'message': messageReport,
        });
  }
}
