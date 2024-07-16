import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:reqres/core/usecases/usecase.dart';
import 'package:reqres/features/auth/domain/entities/auth.dart';
import 'package:reqres/features/auth/domain/repositories/auth_repository.dart';

class Login implements Usecase<String, Params> {
  final AuthRepository repository;

  Login(this.repository);

  @override
  Future<Either<String, String>> call(Params params) async =>
      // TODO: implement call
      await repository.login(
          params.email, params.username, params.password, params.deviceToken);
}

class Params extends Equatable {
  final String email;
  final String username;
  final String password;
  final String? deviceToken;

  const Params(
      {required this.email,
      required this.username,
      required this.password,
      this.deviceToken});
  @override
  List<Object?> get props => [email, username, password, deviceToken];
}
