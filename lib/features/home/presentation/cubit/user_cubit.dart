import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reqres/features/home/domain/usecases/get_users.dart';

import '../../domain/entities/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUsers _getUsers;
  // final GetUser _getUser;

  UserCubit({
    required GetUsers getUsers,
    // required GetUser getUser
  })  : _getUsers = getUsers,
        // : _getUser = getUser,
        super(UserInitial());

  // void fetchUser(int id) async {
  //   emit(UserLoading());

  //   final result = await _getUser(UserParam(id: id));

  //   result.fold((l) => emit(UserFailed(message: l.message)),
  //       (r) => emit(UserLoaded(user: r)));
  // }

  void fetchUsers(int page) async {
    emit(UserLoading());

    final result = await _getUsers(Params(page: page));

    result.fold((l) => emit(UserFailed(message: l.message)),
        (r) => emit(UserLoaded(users: r)));
  }
}
