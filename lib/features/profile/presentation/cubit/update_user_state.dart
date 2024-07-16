part of 'update_user_cubit.dart';

sealed class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object> get props => [];
}

final class UpdateUserInitial extends UpdateUserState {}

final class UpdateUserLoading extends UpdateUserState {}

final class UpdateUserSuccess extends UpdateUserState {
  final User user;

  const UpdateUserSuccess({required this.user});
  @override
  List<Object> get props => [user];
}

final class UpdateUserFailed extends UpdateUserState {
  final String message;

  const UpdateUserFailed({required this.message});

  @override
  List<Object> get props => [message];
}
