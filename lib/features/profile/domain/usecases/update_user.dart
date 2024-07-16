import 'package:dartz/dartz.dart';
import 'package:reqres/core/usecases/usecase.dart';
import 'package:reqres/features/profile/data/models/user_model.dart';
import 'package:reqres/features/profile/domain/entities/user.dart';
import 'package:reqres/features/profile/domain/repositories/user_repository.dart';

class UpdateUser implements Usecase<User, Params> {
  final UserRepository repository;

  UpdateUser(this.repository);
  @override
  Future<Either<String, User>> call(Params params) async =>
      // TODO: implement call
      await repository.updateUser(params.token, params.name, params.birthday,
          params.height, params.weight, params.interests);
}

class Params {
  final String token;
  final String name;
  final String birthday;
  final int height;
  final int weight;
  final List<String> interests;

  Params(
      {required this.token,
      required this.name,
      required this.birthday,
      required this.height,
      required this.weight,
      required this.interests});
}
