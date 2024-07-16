import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:reqres/features/auth/data/models/auth_model.dart';
import 'package:reqres/sl.dart';
import 'package:reqres/theme_manager/value_manager.dart';
import 'package:reqres/utils/shared_pref.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> register(String email, String username, String password);
  Future<String> login(
      String email, String username, String password, String? deviceToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});
  @override
  Future<String> login(String email, String username, String password,
      String? deviceToken) async {
    // Map<String, dynamic> body = {
    //   'email': email,
    //   'username': username,
    //   'password': password,
    // };
    final response = await client
        .post(Uri.parse('${ValueManager.baseUrl}/api/login'), body: {
      'email': email,
      'username': username,
      'password': password,
    }, headers: {
      'accept': '*/*',
      // 'Content-Type': 'application/json',
      'access-control-allow-origin': '*'
    });

    final data = jsonDecode(response.body);
    log('respon status = ${data['message']}');

    if (response.statusCode == 201) {
      log('data result : ${data['message']}');
      return data['access_token'] ?? data['message'];
    } else {
      throw SocketException(data['message'].toString());
    }
  }

  @override
  Future<AuthModel> register(
      String email, String username, String password) async {
    final response = await client.post(
        Uri.parse('${ValueManager.baseUrl}/api/register'),
        body: {'email': email, 'username': username, 'password': password},
        headers: {'accept': '*/*', 'access-control-allow-origin': '*'});

    final data = jsonDecode(response.body);
    log('respon register = $data');

    if (response.statusCode == 201) {
      final result = AuthModel.fromJson(data);
      return result;
    } else if (response.statusCode == 401) {
      final result = await register(email, username, password);
      return result;
    } else {
      throw SocketException(data['message']);
    }
  }
}
