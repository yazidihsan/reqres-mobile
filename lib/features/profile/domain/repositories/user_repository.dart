import 'package:dartz/dartz.dart';
import 'package:reqres/features/profile/data/models/user_model.dart';
import 'package:reqres/features/profile/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<String, User>> createUser(String token, String name,
      String birthday, int height, int weight, List<String> interests);
  Future<Either<String, User>> getUser(String token);
  Future<Either<String, User>> updateUser(String token, String name,
      String birthday, int height, int weight, List<String> interests);
}
