part of 'guardian_cubit.dart';

sealed class GuardianState extends Equatable {
  const GuardianState();

  @override
  List<Object> get props => [];
}

final class GuardianInitial extends GuardianState {}
