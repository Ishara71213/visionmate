import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visionmate/features/volenteer_support/domain/entities/volenteer_request_entity.dart';

class VolunteerRequestModal extends VolunteerRequestEntity {
  const VolunteerRequestModal(
      {final String? requestId,
      final String? title,
      final String? content,
      final String? imageUrl,
      final DateTime? createdDate,
      final String? createdUser,
      final String? createdUserImageUrl,
      final String? acceptedUserUserId,
      final String? acceptedUserName,
      final String? acceptedUserImageUrl,
      final String? createdUserId})
      : super(
            requestId: requestId,
            title: title,
            content: content,
            imageUrl: imageUrl,
            createdUser: createdUser,
            createdUserId: createdUserId,
            createdUserImageUrl: createdUserImageUrl,
            acceptedUserUserId: acceptedUserUserId,
            acceptedUserImageUrl: acceptedUserImageUrl,
            acceptedUserName: acceptedUserName,
            createdDate: createdDate);

  factory VolunteerRequestModal.fromSnapshot(
      DocumentSnapshot documentSnapshot) {
    return VolunteerRequestModal(
        requestId: documentSnapshot.get("requestId"),
        title: documentSnapshot.get("title"),
        content: documentSnapshot.get("content"),
        imageUrl: documentSnapshot.get("imageUrl"),
        createdUser: documentSnapshot.get("createdUser"),
        createdUserId: documentSnapshot.get("createdUserId"),
        createdUserImageUrl: documentSnapshot.get("createdUserImageUrl"),
        acceptedUserName: documentSnapshot.get("acceptedUserName"),
        acceptedUserImageUrl: documentSnapshot.get("acceptedUserImageUrl"),
        acceptedUserUserId: documentSnapshot.get("acceptedUserUserId"));
  }

  Map<String, dynamic> toDocument() {
    return {
      "requestId": requestId,
      "title": title,
      "content": content,
      "imageUrl": imageUrl,
      "createdUser": createdUser,
      "createdDate": createdDate,
      "createdUserId": createdUserId,
      "createdUserImageUrl": createdUserImageUrl,
      "acceptedUserUserId": acceptedUserUserId,
      "acceptedUserName": acceptedUserName,
      "acceptedUserImageUrl": acceptedUserImageUrl,
    };
  }
}
