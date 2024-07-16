import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String message;
  final String accessToken;

  const Auth({required this.message, required this.accessToken});

  @override
  // TODO: implement props
  List<Object?> get props => [message, accessToken];
}
