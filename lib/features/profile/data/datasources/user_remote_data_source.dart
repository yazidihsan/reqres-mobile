import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:reqres/features/profile/data/models/user_model.dart';
import 'package:reqres/features/profile/presentation/cubit/get_user_cubit.dart';
import 'package:reqres/sl.dart';
import 'package:reqres/theme_manager/value_manager.dart';
import 'package:reqres/utils/shared_pref.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> createUser(String token, String name, String birthday,
      int height, int weight, List<String> interests);
  Future<UserModel> getUser(String token);
  Future<UserModel> updateUser(String token, String name, String birthday,
      int height, int weight, List<String> interests);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  Future<String> _relogToken() async {
    final pref = sl<SharedPref>();

    final email = pref.getEmail();
    final user = pref.getPassword();
    final pass = pref.getPassword();

    final response = await client.post(
        Uri.parse('${ValueManager.baseUrl}/api/login'),
        body: jsonEncode({'email': email, 'username': user, 'password': pass}),
        headers: {
          'accept': '*/*',
          // 'Content-Type': 'application/json'
          'access-control-allow-origin': '*'
        });

    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      final token = data['token'];

      await pref.setAccessToken(token);

      return token;
    } else {
      throw SocketException(data['message']);
    }
  }

  @override
  Future<UserModel> createUser(String token, String name, String birthday,
      int height, int weight, List<String> interests) async {
    Map<String, dynamic> body = {
      "name": name,
      "birthday": birthday,
      "height": height,
      "weight": weight,
      "interests": jsonDecode(jsonEncode(interests))
    };

    final response = await client.post(
        Uri.parse('${ValueManager.baseUrl}/api/createProfile'),
        body: jsonEncode(body),
        headers: {
          'accept': '*/*',
          'x-access-token': token,
          "Content-Type": "application/json",
        });

    final data = jsonDecode(response.body);
    log('create data : ${data['data']}');
    if (response.statusCode == 201) {
      final profile = UserModel.fromJson(data['data']);
      log("data profile: ${profile.toString()}");
      return profile;
    } else if (response.statusCode == 401 || response.statusCode == 500) {
      final newToken = await _relogToken();

      final result =
          await createUser(newToken, name, birthday, height, weight, interests);

      return result;
    } else {
      throw SocketException(data['message']);
    }
  }

  @override
  Future<UserModel> getUser(String token) async {
    // TODO: implement getUser
    final response = await client.get(
      Uri.parse('${ValueManager.baseUrl}/api/getProfile'),
      headers: {
        'accept': '*/*',
        'access-control-allow-origin': '*',
        'x-access-token': token
      },
    );

    final data = jsonDecode(response.body);
    // log('get data : ${data['data']}');

    if (response.statusCode == 200) {
      final profile = UserModel.fromJson(data['data']);
      log("data profile: ${data['data'].toString()}");
      return profile;
    } else if (response.statusCode == 401) {
      final newToken = await _relogToken();

      final result = await getUser(newToken);

      return result;
    } else {
      throw SocketException(data['message']);
    }
  }

  @override
  Future<UserModel> updateUser(String token, String name, String birthday,
      int height, int weight, List<String> interests) async {
    Map<String, dynamic> body = {
      "name": name,
      "birthday": birthday,
      "height": height,
      "weight": weight,
      "interests": jsonDecode(jsonEncode(interests))
    };
    // TODO: implement updateUser
    final response = await client.put(
        Uri.parse('${ValueManager.baseUrl}/api/updateProfile'),
        body: jsonEncode(body),
        headers: {
          'accept': '*/*',
          'x-access-token': token,
          "Content-Type": "application/json",
        });

    final data = jsonDecode(response.body);
    log('update data : $data');

    if (response.statusCode == 200) {
      final profile = UserModel.fromJson(data['data']);
      log("data profile: ${profile.toString()}");
      return profile;
    } else if (response.statusCode == 401) {
      final newToken = sl<SharedPref>().getAccessToken();

      final result = await updateUser(
          newToken ?? '', name, birthday, height, weight, interests);

      return result;
    } else {
      throw SocketException(data['message']);
    }
  }
}
