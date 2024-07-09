import 'package:dartz/dartz.dart';
import 'package:reqres/core/failure/failure.dart';
import 'package:reqres/core/usecases/usecase.dart';
import 'package:reqres/features/home/domain/entities/user.dart';
import 'package:reqres/features/home/domain/repositories/home_repository.dart';

class GetUser implements Usecase<User, UserParam> {
  final HomeRepository repository;

  GetUser(this.repository);

  @override
  Future<Either<Failure, User>> call(UserParam params) async =>
      // TODO: implement call
      await repository.getUser(params.id);
}

class UserParam {
  final int id;

  const UserParam({required this.id});
}
