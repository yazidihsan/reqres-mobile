import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:reqres/core/usecases/usecase.dart';
import 'package:reqres/features/auth/domain/entities/auth.dart';
import 'package:reqres/features/auth/domain/repositories/auth_repository.dart';

class Register implements Usecase<Auth, Params> {
  final AuthRepository repository;

  Register(this.repository);
  @override
  Future<Either<String, Auth>> call(Params params) async =>
      // TODO: implement call
      await repository.register(params.email, params.username, params.password);
}

class Params extends Equatable {
  final String email;
  final String username;
  final String password;

  const Params(
      {required this.email, required this.username, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [email, username, password];
}
