import 'package:equatable/equatable.dart';

class VolunteerRequestEntity extends Equatable {
  final String? title;
  final String? content;
  final String? imageUrl;
  final DateTime? createdDate;
  final String? createdUser;
  final String? acceptedUserUserId;
  final String? createdUserId;

  const VolunteerRequestEntity(
      {this.title,
      this.content,
      this.imageUrl,
      this.createdDate,
      this.createdUser,
      this.createdUserId,
      this.acceptedUserUserId});

  @override
  List<Object?> get props => [
        title,
        content,
        imageUrl,
        createdDate,
        createdUser,
        createdUserId,
        acceptedUserUserId
      ];
}
