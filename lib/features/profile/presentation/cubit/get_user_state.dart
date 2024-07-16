part of 'get_user_cubit.dart';

sealed class GetUserState extends Equatable {
  const GetUserState();

  @override
  List<Object> get props => [];
}

final class GetUserInitial extends GetUserState {}

final class GetUserLoading extends GetUserState {}

final class GetUserSuccess extends GetUserState {
  final User user;
  // final String email;
  // final String username;
  // final String name;
  // final String birthday;
  // final String horoscope;
  // final String zodiac;
  // final int height;
  // final int weight;
  // final List<String> interests;

  const GetUserSuccess({required this.user
      // required this.email,
      // required this.username,
      // required this.name,
      // required this.birthday,
      // required this.horoscope,
      // required this.zodiac,
      // required this.height,
      // required this.weight,
      // required this.interests
      });

  @override
  List<Object> get props => [user];
}

final class GetUserFailed extends GetUserState {
  final String message;

  const GetUserFailed({required this.message});

  @override
  List<Object> get props => [message];
}
