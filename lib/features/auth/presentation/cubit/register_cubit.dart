import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reqres/features/auth/domain/entities/auth.dart';
import 'package:reqres/features/auth/domain/usecases/register.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final Register _register;
  RegisterCubit({required Register register})
      : _register = register,
        super(RegisterInitial());

  void startRegister(String email, String username, String password) async {
    emit(RegisterLoading());

    final result = await _register(
        Params(email: email, username: username, password: password));

    result.fold((l) => emit(RegisterFailed(message: l)),
        (r) => emit(RegisterSuccess(auth: r)));
  }
}
