import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visionmate/core/common/domain/entities/guardian_user_entity.dart';

class GuardianUserModel extends GuardianUserEntity {
  const GuardianUserModel(
      {final String? vissuallyImpairedUserId,
      final bool isAllowedLivelocationShare = false})
      : super(
            vissuallyImpairedUserId: vissuallyImpairedUserId,
            isAllowedLivelocationShare: isAllowedLivelocationShare);

  factory GuardianUserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return GuardianUserModel(
      vissuallyImpairedUserId: documentSnapshot.get("vissuallyImpairedUserId"),
      isAllowedLivelocationShare:
          documentSnapshot.get("isAllowedLivelocationShare"),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "vissuallyImpairedUserId": vissuallyImpairedUserId,
      "isAllowedLivelocationShare": isAllowedLivelocationShare,
    };
  }
}
