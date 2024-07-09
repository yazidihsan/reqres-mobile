import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:reqres/features/home/data/models/user_model.dart';
import 'package:reqres/features/home/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tUserModel = UserModel(
    id: 7,
    email: 'michael.lawson@reqres.in',
    firstName: 'Michael',
    lastName: 'Lawson',
    avatar: 'https://reqres.in/img/faces/7-image.jpg',
  );

  test('should be a subclass of User entity', () {
    expect(tUserModel, isA<User>());
  });

  group('fromJson', () {
    test('should return a valid user model', () {
      final jsonMap = json.decode(fixture('user.json'));
      final result = UserModel.fromJson(jsonMap);

      expect(result, tUserModel);
    });
  });

  group('toJson', () {
    test('should return a JSON User map', () {
      final result = tUserModel.toJson();

      final expectedMap = {
        "id": 7,
        "email": "michael.lawson@reqres.in",
        "first_name": "Michael",
        "last_name": "Lawson",
        "avatar": "https://reqres.in/img/faces/7-image.jpg"
      };

      expect(result, expectedMap);
    });
  });
}
