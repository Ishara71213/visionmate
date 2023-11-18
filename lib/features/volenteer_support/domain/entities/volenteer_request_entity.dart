import 'package:equatable/equatable.dart';

class VolunteerRequestEntity extends Equatable {
  final String? requestId;
  final String? title;
  final String? content;
  final String? imageUrl;
  final DateTime? createdDate;
  final String? createdUser;
  final String? createdUserId;
  final String? createdUserImageUrl;
  final String? acceptedUserUserId;
  final String? acceptedUserName;
  final String? acceptedUserImageUrl;

  const VolunteerRequestEntity(
      {this.requestId,
      this.title,
      this.content,
      this.imageUrl,
      this.createdDate,
      this.createdUser,
      this.createdUserId,
      this.acceptedUserName,
      this.acceptedUserImageUrl,
      this.createdUserImageUrl,
      this.acceptedUserUserId});

  @override
  List<Object?> get props => [
        requestId,
        title,
        content,
        imageUrl,
        createdDate,
        createdUser,
        createdUserId,
        createdUserImageUrl,
        acceptedUserName,
        acceptedUserImageUrl,
        acceptedUserUserId,
      ];
}
