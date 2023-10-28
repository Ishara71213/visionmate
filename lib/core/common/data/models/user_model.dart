import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visionmate/core/constants/user_types.dart';
import 'package:visionmate/core/common/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {final String? firstName,
      final String? lastName,
      final String? email,
      final String? uid,
      final String? dob,
      final String? status,
      final String? password,
      final String? imageUrl,
      final String? userType})
      : super(
            uid: uid,
            firstName: firstName,
            lastName: lastName,
            email: email,
            dob: dob,
            status: status,
            password: password,
            imageUrl: imageUrl,
            userType: userType);

  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
      uid: documentSnapshot.get("uid"),
      firstName: documentSnapshot.get("firstName"),
      lastName: documentSnapshot.get("lastName"),
      email: documentSnapshot.get("email"),
      dob: documentSnapshot.get("dob"),
      status: documentSnapshot.get("status"),
      userType: documentSnapshot.get("userType"),
      imageUrl: documentSnapshot.get("imageUrl"),
    );
  }
  Map<String, dynamic> toDocument() {
    return {
      "status": status,
      "uid": uid,
      "dob": dob,
      "email": email,
      "userType": userType,
      "imageUrl": imageUrl,
      "firstName": firstName,
      "lastName": lastName
    };
  }

  factory UserModel.fromSnapshotUserEmail(DocumentSnapshot documentSnapshot) {
    return UserModel(uid: documentSnapshot.get("uid"));
  }

  Map<String, dynamic> toDocumentUserEmail() {
    return {
      "uid": uid,
    };
  }

  factory UserModel.fromSnapshotUserType(DocumentSnapshot documentSnapshot) {
    return UserModel(
      userType: documentSnapshot.get("userType"),
    );
  }

  Map<String, dynamic> toDocumentUserType() {
    return {
      "userType": userType,
    };
  }

  factory UserModel.fromSnapshotImageUrl(DocumentSnapshot documentSnapshot) {
    return UserModel(
      imageUrl: documentSnapshot.get("imageUrl"),
    );
  }

  Map<String, dynamic> toDocumentImageUrl() {
    return {
      "imageUrl": imageUrl,
    };
  }
}
