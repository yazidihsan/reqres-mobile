part of 'create_user_cubit.dart';

sealed class CreateUserState extends Equatable {
  const CreateUserState();

  @override
  List<Object> get props => [];
}

final class CreateUserInitial extends CreateUserState {}

final class CreateUserLoading extends CreateUserState {}

final class CreateUserSuccess extends CreateUserState {
  final User user;

  const CreateUserSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

final class CreateUserFailed extends CreateUserState {
  final String message;

  const CreateUserFailed({required this.message});
  @override
  List<Object> get props => [message];
}
