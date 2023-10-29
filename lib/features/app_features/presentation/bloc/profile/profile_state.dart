part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfileImageLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfileImageSuccess extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfileImageFailure extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfiledataUpdateLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfiledataUpdateSuccess extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfiledataUpdateFailure extends ProfileState {
  @override
  List<Object> get props => [];
}
