import 'package:dartz/dartz.dart';
import 'package:reqres/features/auth/domain/entities/auth.dart';

abstract class AuthRepository {
  Future<Either<String, Auth>> register(
      String email, String username, String password);
  Future<Either<String, String>> login(
      String email, String username, String password, String? token);
}
