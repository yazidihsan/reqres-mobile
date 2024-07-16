import 'package:reqres/features/auth/domain/entities/auth.dart';

class AuthModel extends Auth {
  const AuthModel({required super.message, required super.accessToken});

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      AuthModel(message: json['message'], accessToken: json['access_token']);

  Map<String, dynamic> toJson() =>
      {"message": message, "access_token": accessToken};
}
