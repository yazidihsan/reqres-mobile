import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;

  const User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  @override
  List<Object?> get props => [id, email, firstName, lastName, avatar];
}
