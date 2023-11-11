part of 'community_cubit.dart';

sealed class CommunityState extends Equatable {
  const CommunityState();

  @override
  List<Object> get props => [];
}

final class CommunityInitial extends CommunityState {}

final class CommunityPhotoUploading extends CommunityState {}

final class CommunityPhotoUploadingomplete extends CommunityState {}

final class CommunityPostUploadLoading extends CommunityState {}

final class CommunityPostUploadSuccess extends CommunityState {}

final class CommunityPostUploadFailed extends CommunityState {}
