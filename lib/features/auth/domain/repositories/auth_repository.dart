import 'package:dartz/dartz.dart';
import 'package:reqres/core/failure/failure.dart';

abstract class AuthRepository {
  Future<Either<String, String>> register(
      String email, String username, String password);
  Future<Either<String, String>> login(
      String email, String username, String password, String? token);
}
