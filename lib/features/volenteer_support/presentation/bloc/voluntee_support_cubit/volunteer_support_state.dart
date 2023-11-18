part of 'volunteer_support_cubit.dart';

sealed class VolunteerSupportState extends Equatable {
  const VolunteerSupportState();

  @override
  List<Object> get props => [];
}

final class VolunteerSupportInitial extends VolunteerSupportState {}

final class VlounteerSupportPhotoUploading extends VolunteerSupportState {}

final class VlounteerSupportPhotoUploadingomplete
    extends VolunteerSupportState {}

final class VlounteerSupportRequestUploadLoading
    extends VolunteerSupportState {}

final class VlounteerSupportRequestUploadSuccess
    extends VolunteerSupportState {}

final class VlounteerSupportRequestUploadFailed extends VolunteerSupportState {}

final class VlounteerSupportRequestDeleteSuccess
    extends VolunteerSupportState {}

final class VlounteerSupportRequestDeleteFailed extends VolunteerSupportState {}
