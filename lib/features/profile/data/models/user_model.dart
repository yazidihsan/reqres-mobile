import 'dart:convert';

import 'package:reqres/features/profile/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.name,
      required super.birthday,
      required super.height,
      required super.weight,
      required super.interest});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      name: json["name"],
      birthday: json["birthday"],
      height: int.parse(json["height"].toString()),
      weight: int.parse(json["weight"].toString()),
      interest: List<String>.from(json['interests']).toList());

  Map<String, dynamic> toJson() => {
        "name": name,
        "birthday": birthday,
        "height": height,
        "weight": weight,
        "interests": jsonDecode(jsonEncode(interest))
      };
}
