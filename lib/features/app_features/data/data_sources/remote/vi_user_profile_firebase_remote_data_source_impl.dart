import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visionmate/core/common/domain/entities/guardian_user_entity.dart';
import 'package:visionmate/core/common/domain/entities/visually_impaired_user_entity.dart';
import 'package:visionmate/core/common/data/models/guardian_user_model.dart';
import 'package:visionmate/core/common/data/models/user_model.dart';
import 'package:visionmate/core/common/data/models/visually_impaired_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:visionmate/features/app_features/data/data_sources/remote/vi_user_profile_firebase_remote_data_source.dart';

class ViProfileFirebaseRemoteDataSourceImpl
    extends ViProfileFirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  ViProfileFirebaseRemoteDataSourceImpl(
      {required this.auth, required this.firestore});

  @override
  Future<VisuallyImpairedUserEntity> getCurrentViUserTypeInfo() async {
    CollectionReference userCollectionRef;
    userCollectionRef = firestore.collection("VisuallyImpairedUsers");

    final uid = auth.currentUser!.uid;

    VisuallyImpairedUserModel userInfo = const VisuallyImpairedUserModel(
        disability: "",
        emergencyContact: "",
        emergencyContactName: "",
        recidenceAddress: "",
        recidenceCordinate: null,
        guardianId: "",
        visitLocation: null);

    await userCollectionRef.doc(uid).get().then((value) {
      if (value.exists) {
        VisuallyImpairedUserModel user =
            VisuallyImpairedUserModel.fromSnapshot(value);

        userInfo = VisuallyImpairedUserModel(
            disability: user.disability,
            emergencyContact: user.emergencyContact,
            emergencyContactName: user.emergencyContactName,
            recidenceAddress: user.recidenceAddress,
            recidenceCordinate: user.recidenceCordinate,
            guardianId: user.guardianId,
            visitLocation: user.visitLocation);
      }
    });
    return userInfo;
  }

  @override
  Future<void> deleteCurrentViUserTypeInfo() {
    // TODO: implement deleteCurrentViUserTypeInfo
    throw UnimplementedError();
  }

  @override
  Future<VisuallyImpairedUserEntity> updateCurrentViUserTypeInfo(
      VisuallyImpairedUserEntity entity) {
    // TODO: implement updateCurrentViUserTypeInfo
    throw UnimplementedError();
  }
}
