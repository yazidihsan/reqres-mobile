import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? name;
  final String? birthday;
  final int? height;
  final int? weight;

  final List<String> interest;
  const User(
      {required this.name,
      required this.birthday,
      required this.height,
      required this.weight,
      required this.interest});
  @override
  // TODO: implement props
  List<Object?> get props => [name, birthday, height, weight, interest];
}
