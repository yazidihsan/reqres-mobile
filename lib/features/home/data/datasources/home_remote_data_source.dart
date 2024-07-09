import 'dart:convert';

import 'package:reqres/core/exception/exception.dart';
import 'package:reqres/features/home/data/models/user_model.dart';

import '../../../../theme_manager/value_manager.dart';
import 'package:http/http.dart' as http;

abstract class HomeRemoteDataSource {
  Future<List<UserModel>> getUsers(int page);
  Future<UserModel> getUser(int id);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final http.Client client;

  HomeRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> getUser(id) async {
    final response =
        await client.get(Uri.parse('${ValueManager.baseUrl}/api/users/$id'));
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final user = UserModel.fromJson(data['data']);
      return user;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<UserModel>> getUsers(int page) async {
    final response = await client
        .get(Uri.parse('${ValueManager.baseUrl}/api/users?page=$page'));

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final users =
          List.from(data['data']).map((e) => UserModel.fromJson(e)).toList();

      return users;
    } else {
      throw ServerException();
    }
  }
}
