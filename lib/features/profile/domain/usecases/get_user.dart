import 'package:dartz/dartz.dart';
import 'package:reqres/core/usecases/usecase.dart';
import 'package:reqres/features/profile/domain/entities/user.dart';
import 'package:reqres/features/profile/domain/repositories/user_repository.dart';

class GetUser implements Usecase<User, GetParams> {
  final UserRepository repository;

  GetUser(this.repository);
  @override
  Future<Either<String, User>> call(GetParams params) async =>
      await repository.getUser(params.token);
}

class GetParams {
  final String token;

  GetParams({required this.token});
}
