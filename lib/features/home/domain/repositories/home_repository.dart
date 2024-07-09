import 'package:dartz/dartz.dart';
import 'package:reqres/core/failure/failure.dart';
import 'package:reqres/features/home/domain/entities/user.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<User>>> getUsers(int page);
  Future<Either<Failure, User>> getUser(int id);
}
