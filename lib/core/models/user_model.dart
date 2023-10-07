import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visionmate/core/constants/user_types.dart';
import 'package:visionmate/core/util/functions/user_type_helper.dart';
import 'package:visionmate/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {final String? name,
      final String? email,
      final String? uid,
      final String? dob,
      final String? status,
      final String? password,
      final String? userType})
      : super(
            uid: uid,
            name: name,
            email: email,
            dob: dob,
            status: status,
            password: password,
            userType: userType);

  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
      uid: documentSnapshot.get("uid"),
      name: documentSnapshot.get("name"),
      email: documentSnapshot.get("email"),
      dob: documentSnapshot.get("dob"),
      status: documentSnapshot.get("status"),
      userType: documentSnapshot.get("userType"),
    );
  }
  Map<String, dynamic> toDocument() {
    return {
      "status": status,
      "uid": uid,
      "dob": dob,
      "email": email,
      "userType": userType,
      "name": name
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
}
