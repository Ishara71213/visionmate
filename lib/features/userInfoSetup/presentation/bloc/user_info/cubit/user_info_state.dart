part of 'user_info_cubit.dart';

sealed class UserInfoState extends Equatable {
  const UserInfoState();

  @override
  List<Object> get props => [];
}

final class UserInfoInitial extends UserInfoState {
  @override
  List<Object> get props => [];
}

final class UserInfoLoading extends UserInfoState {
  @override
  List<Object> get props => [];
}

final class UserInfoFailrue extends UserInfoState {
  @override
  List<Object> get props => [];
}

final class UserInfoSuccess extends UserInfoState {
  @override
  List<Object> get props => [];
}
