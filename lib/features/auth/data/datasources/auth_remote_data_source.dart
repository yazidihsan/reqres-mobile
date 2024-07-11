import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:reqres/sl.dart';
import 'package:reqres/theme_manager/value_manager.dart';
import 'package:reqres/utils/shared_pref.dart';

abstract class AuthRemoteDataSource {
  Future<String> register(String email, String username, String password);
  Future<String> login(
      String email, String username, String password, String? deviceToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});
  @override
  Future<String> login(String email, String username, String password,
      String? deviceToken) async {
    final response = await client
        .post(Uri.parse('${ValueManager.baseUrl}/api/login'), body: {
      'email': email,
      'username': username,
      'password': password,
    }, headers: {
      'accept': '*/*',
      'access-control-allow-origin': '*'
    });

    final data = jsonDecode(response.body);
    log('respon login = $data');

    if (response.statusCode == 200) {
      final SharedPref pref = sl<SharedPref>();
      await pref.setAccessToken(data['access_token']);
      return data['access_token'];
    } else if (response.statusCode == 401) {
      final result = await login(email, username, password, deviceToken);

      return result;
    } else {
      throw SocketException(data['message']);
    }
  }

  @override
  Future<String> register(
      String email, String username, String password) async {
    final response = await client.post(
        Uri.parse('${ValueManager.baseUrl}/api/register'),
        body: {'email': email, 'username': username, 'password': password},
        headers: {'accept': '*/*', 'access-control-allow-origin': '*'});

    final data = jsonDecode(response.body);
    log('respon register = $data');

    if (response.statusCode == 200) {
      return data['message'];
    } else if (response.statusCode == 401) {
      final result = await register(email, username, password);
      return result;
    } else {
      throw SocketException(data['message']);
    }
  }
}
