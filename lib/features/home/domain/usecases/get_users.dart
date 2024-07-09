import 'package:dartz/dartz.dart';
import 'package:reqres/core/failure/failure.dart';
import 'package:reqres/core/usecases/usecase.dart';
import 'package:reqres/features/home/domain/entities/user.dart';
import 'package:reqres/features/home/domain/repositories/home_repository.dart';

class GetUsers implements Usecase<List<User>, Params> {
  final HomeRepository repository;

  GetUsers(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(Params params) async =>
      await repository.getUsers(params.page);
}

class Params {
  final int page;

  const Params({required this.page});
}
