import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'increment_state.dart';

class IncrementCubit extends Cubit<IncrementState> {
  IncrementCubit() : super(IncrementInitial());
}
