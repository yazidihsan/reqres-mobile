import 'package:dartz/dartz.dart';
import 'package:reqres/core/failure/failure.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
