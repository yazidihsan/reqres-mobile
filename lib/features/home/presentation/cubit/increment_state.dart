part of 'increment_cubit.dart';

sealed class IncrementState extends Equatable {
  const IncrementState();

  @override
  List<Object> get props => [];
}

final class IncrementInitial extends IncrementState {}
