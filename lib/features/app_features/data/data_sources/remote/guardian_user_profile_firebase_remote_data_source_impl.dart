import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visionmate/core/common/data/models/guardian_user_model.dart';
import 'package:visionmate/core/common/domain/entities/guardian_user_entity.dart';
import 'package:visionmate/core/common/domain/entities/visually_impaired_user_entity.dart';
import 'package:visionmate/core/common/data/models/visually_impaired_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:visionmate/features/app_features/data/data_sources/remote/guardian_user_profile_firebase_remote_data_source.dart';

class GuardianProfileFirebaseRemoteDataSourceImpl
    extends GuardianProfileFirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  GuardianProfileFirebaseRemoteDataSourceImpl(
      {required this.auth, required this.firestore});

  @override
  Future<GuardianUserEntity> getCurrentGuardianUserTypeInfo() async {
    CollectionReference userCollectionRef;
    userCollectionRef = firestore.collection("GuardianUsers");

    final uid = auth.currentUser!.uid;

    GuardianUserModel userInfo = const GuardianUserModel(
        vissuallyImpairedUserId: "", isAllowedLivelocationShare: false);

    await userCollectionRef.doc(uid).get().then((value) {
      if (value.exists) {
        GuardianUserModel user = GuardianUserModel.fromSnapshot(value);

        userInfo = GuardianUserModel(
            vissuallyImpairedUserId: user.vissuallyImpairedUserId,
            isAllowedLivelocationShare: user.isAllowedLivelocationShare);
      }
    });
    return userInfo;
  }

  @override
  Future<void> deleteCurrentGuardianUserTypeInfo() {
    // TODO: implement deleteCurrentViUserTypeInfo
    throw UnimplementedError();
  }

  @override
  Future<GuardianUserEntity> updateCurrentGuardianUserTypeInfo() {
    // TODO: implement updateCurrentViUserTypeInfo
    throw UnimplementedError();
  }
}
