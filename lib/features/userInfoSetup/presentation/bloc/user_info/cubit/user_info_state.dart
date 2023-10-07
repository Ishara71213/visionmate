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

class UserInfoLocationDataGathering extends UserInfoState {
  final LatLng curruntLocation;
  const UserInfoLocationDataGathering(
      {this.curruntLocation = const LatLng(10, 10.0)});
  @override
  List<Object> get props => [curruntLocation];
}

final class UserInfoLinkUser extends UserInfoState {
  @override
  List<Object> get props => [];
}

final class UserInfoLinkUserLoading extends UserInfoState {
  @override
  List<Object> get props => [];
}

final class UserInfoLinkUserFailrue extends UserInfoState {
  @override
  List<Object> get props => [];
}

final class UserInfoLinkUserSuccess extends UserInfoState {
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
