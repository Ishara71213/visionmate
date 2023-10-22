import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visionmate/core/entities/guardian_user_entity.dart';
import 'package:visionmate/core/entities/visually_impaired_user_entity.dart';
import 'package:visionmate/core/models/guardian_user_model.dart';
import 'package:visionmate/core/models/user_model.dart';
import 'package:visionmate/core/models/visually_impaired_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:visionmate/features/app_features/data/data_sources/remote/app_features_firebase_remote_data_source.dart';

class AppFeaturesFirebaseRemoteDataSourceImpl
    extends AppFeaturesFirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AppFeaturesFirebaseRemoteDataSourceImpl(
      {required this.auth, required this.firestore});

  @override
  Future<VisuallyImpairedUserEntity> getCurrentViUserTypeInfo() async {
    CollectionReference userCollectionRef;
    userCollectionRef = firestore.collection("VisuallyImpairedUsers");

    final uid = await getCurrentUId();

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
  Future<void> createCurrentGuardianUserTypeInfo(
      GuardianUserEntity user) async {
    CollectionReference userCollectionRef;
    userCollectionRef = firestore.collection("Guardians");

    final uid = await getCurrentUId();

    await userCollectionRef.doc(uid).get().then((value) {
      if (!value.exists) {
        final userInfo = GuardianUserModel(
                vissuallyImpairedUserId: user.vissuallyImpairedUserId,
                isAllowedLivelocationShare: user.isAllowedLivelocationShare)
            .toDocument();

        userCollectionRef.doc(uid).set(userInfo);
      }
      return;
    });
  }

  @override
  Future<String> getCurrentUId() async => auth.currentUser!.uid;

  @override
  Future<String> getUserIdByEmail(String email) async {
    CollectionReference userEmailsCollectionRef;
    userEmailsCollectionRef = firestore.collection("UserEmails");
    String uid = "";
    await userEmailsCollectionRef.doc(email).get().then((value) {
      if (value.exists) {
        UserModel asignUser = UserModel.fromSnapshotUserEmail(value);
        uid = asignUser.uid.toString();
        return uid;
      }
    });
    return uid;
  }
}
