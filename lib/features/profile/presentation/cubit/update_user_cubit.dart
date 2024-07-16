import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reqres/features/profile/data/models/user_model.dart';
import 'package:reqres/features/profile/domain/entities/user.dart';
import 'package:reqres/features/profile/domain/usecases/update_user.dart';
import 'package:reqres/utils/shared_pref.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  final UpdateUser _updateUser;
  final SharedPref _sharedPref;
  UpdateUserCubit(
      {required UpdateUser updateUser, required SharedPref sharedPref})
      : _sharedPref = sharedPref,
        _updateUser = updateUser,
        super(UpdateUserInitial());

  void updateProfile(String name, String birthday, int height, int weight,
      List<String> interests) async {
    emit(UpdateUserLoading());

    final token = _sharedPref.getAccessToken();

    final result = await _updateUser(Params(
        token: token ?? '',
        name: name,
        birthday: birthday,
        height: height,
        weight: weight,
        interests: interests));

    result.fold((l) => emit(UpdateUserFailed(message: l)), (r) {
      log('data update cubit: $r');
      emit(UpdateUserSuccess(user: r));
    });
  }
}
