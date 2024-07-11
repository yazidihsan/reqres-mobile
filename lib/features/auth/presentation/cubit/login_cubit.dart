import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reqres/features/auth/domain/usecases/login.dart';
import 'package:reqres/utils/shared_pref.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Login _login;
  final SharedPref _sharedPref;
  LoginCubit({required Login login, required SharedPref sharedPref})
      : _sharedPref = sharedPref,
        _login = login,
        super(LoginInitial());

  void startLogin(String email, String username, String password) async {
    emit(LoginLoading());
    // final token = _sharedPref.getAccessToken();

    final result = await _login(
        Params(email: email, username: username, password: password));

    result.fold(
        (l) => emit(LoginFailed(message: l)),
        (r) =>
            // await _sharedPref.setAccessToken(r);
            emit(LoginSuccess(message: r)));
  }
}
