part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

final class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

final class UserFailrue extends UserState {
  @override
  List<Object> get props => [];
}

final class UserSuccess extends UserState {
  @override
  List<Object> get props => [];
}
