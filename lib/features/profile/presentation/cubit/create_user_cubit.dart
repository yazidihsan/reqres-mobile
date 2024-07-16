import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reqres/features/profile/data/models/user_model.dart';
import 'package:reqres/features/profile/domain/entities/user.dart';
import 'package:reqres/features/profile/domain/usecases/create_user.dart';
import 'package:reqres/utils/shared_pref.dart';

part 'create_user_state.dart';

class CreateUserCubit extends Cubit<CreateUserState> {
  final CreateUser _createUser;
  final SharedPref _sharedPref;
  CreateUserCubit(
      {required CreateUser createUser, required SharedPref sharedPref})
      : _sharedPref = sharedPref,
        _createUser = createUser,
        super(CreateUserInitial());

  void createProfile(String name, String birthday, int height, int weight,
      List<String> interests) async {
    emit(CreateUserLoading());

    final token = _sharedPref.getAccessToken();
    // List<dynamic> items = [];

    // String item1 = 'aku';
    // String item2 = 'kamu';
    // String item3 = 'kita';

    // items.add(item1);
    // items.add(item2);
    // items.add(item3);

    final result = await _createUser(CreateParams(
        token: token ?? '',
        name: name,
        birthday: birthday,
        height: height,
        weight: weight,
        interests: interests));

    result.fold((l) => emit(CreateUserFailed(message: l)),
        (r) => emit(CreateUserSuccess(user: r)));
  }
}
