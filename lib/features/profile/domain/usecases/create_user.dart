import 'package:dartz/dartz.dart';
import 'package:reqres/core/usecases/usecase.dart';
import 'package:reqres/features/profile/data/models/user_model.dart';
import 'package:reqres/features/profile/domain/entities/user.dart';
import 'package:reqres/features/profile/domain/repositories/user_repository.dart';

class CreateUser implements Usecase<User, CreateParams> {
  final UserRepository repository;

  CreateUser(this.repository);
  @override
  Future<Either<String, User>> call(CreateParams params) async =>
      // TODO: implement call
      await repository.createUser(params.token, params.name, params.birthday,
          params.height, params.weight, params.interests);
}

class CreateParams {
  final String token;
  final String name;
  final String birthday;
  final int height;
  final int weight;
  final List<String> interests;

  CreateParams(
      {required this.token,
      required this.name,
      required this.birthday,
      required this.height,
      required this.weight,
      required this.interests});
}
