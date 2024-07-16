part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final Auth auth;

  const RegisterSuccess({required this.auth});

  @override
  List<Object> get props => [auth];
}

final class RegisterFailed extends RegisterState {
  final String message;

  const RegisterFailed({required this.message});

  @override
  List<Object> get props => [message];
}
