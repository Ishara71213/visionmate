import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visionmate/features/app_features/domain/entities/post_entity.dart';

class PostModal extends PostEntity {
  const PostModal(
      {final String? title,
      final String? content,
      final String? imageUrl,
      final String? createdUser,
      final String? createdUserId,
      final DateTime? createdDate})
      : super(
            title: title,
            content: content,
            imageUrl: imageUrl,
            createdUser: createdUser,
            createdUserId: createdUserId,
            createdDate: createdDate);

  factory PostModal.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return PostModal(
      title: documentSnapshot.get("title"),
      content: documentSnapshot.get("content"),
      imageUrl: documentSnapshot.get("imageUrl"),
      createdUser: documentSnapshot.get("createdUser"),
      createdUserId: documentSnapshot.get("createdUserId"),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "title": title,
      "content": content,
      "imageUrl": imageUrl,
      "createdUser": createdUser,
      "createdDate": createdDate,
      "createdUserId": createdUserId,
    };
  }
}
