import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reqres/features/profile/domain/entities/user.dart';
import 'package:reqres/features/profile/domain/usecases/get_user.dart';
import 'package:reqres/utils/shared_pref.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  final GetUser _getUser;
  final SharedPref _sharedPref;
  GetUserCubit({required GetUser getUser, required SharedPref sharedPref})
      : _sharedPref = sharedPref,
        _getUser = getUser,
        super(GetUserInitial());

  void getUser() async {
    emit(GetUserLoading());

    final token = _sharedPref.getAccessToken();

    final result = await _getUser(GetParams(token: token ?? ''));

    result.fold((l) => emit(GetUserFailed(message: l)), (r) {
      log('data get : $r');
      // await Future.delayed(const Duration(seconds: 2));
      emit(GetUserSuccess(user: r
          // email: r.value1,
          // username: r.value2,
          // name: r.value3,
          // birthday: r.value4,
          // horoscope: r.value5,
          // zodiac: r.value6,
          // height: r.value7,
          // weight: r.value8,
          // interests: r.value9
          ));
    });
  }
}
