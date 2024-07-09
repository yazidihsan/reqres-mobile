part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  final List<User> users;
  // final User user;
  const UserLoaded({required this.users});
  // const UserLoaded({required this.user});

  @override
  List<Object> get props => [users];
  // List<Object> get props => [user];
}

final class UserFailed extends UserState {
  final String message;

  const UserFailed({required this.message});

  @override
  List<Object> get props => [message];
}
