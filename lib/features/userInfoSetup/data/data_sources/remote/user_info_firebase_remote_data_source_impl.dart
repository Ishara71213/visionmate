import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visionmate/core/entities/visually_impaired_user_entity.dart';
import 'package:visionmate/core/models/visually_impaired_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:visionmate/features/userInfoSetup/data/data_sources/remote/user_info_firebase_remote_data_source.dart';

class UserInfoFirebaseRemoteDataSourceImpl
    extends UserInfoFirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  UserInfoFirebaseRemoteDataSourceImpl(
      {required this.auth, required this.firestore});

  @override
  Future<void> createCurrentViUserTypeInfo(
      VisuallyImpairedUserEntity user) async {
    CollectionReference userCollectionRef;
    userCollectionRef = firestore.collection("VisuallyImpairedUsers");

    final uid = await getCurrentUId();

    await userCollectionRef.doc(uid).get().then((value) {
      if (!value.exists) {
        final userInfo = VisuallyImpairedUserModel(
                disability: user.disability,
                emergencyContact: user.emergencyContact,
                emergencyContactName: user.emergencyContactName,
                recidenceAddress: user.recidenceAddress,
                recidenceCordinate: user.recidenceCordinate,
                guardianId: user.guardianId,
                visitLocation: user.visitLocation)
            .toDocument();

        userCollectionRef.doc(uid).set(userInfo);
      }
      return;
    });

    //   userTypeCollectionRef = firestore.collection("Volunteers");
  }

  @override
  Future<void> createCurrentGuardianUserTypeInfo(
      VisuallyImpairedUserEntity user) async {
    CollectionReference userCollectionRef;
    userCollectionRef = firestore.collection("Guardians");

    final uid = await getCurrentUId();

    await userCollectionRef.doc(uid).get().then((value) {
      if (!value.exists) {
        final userInfo = VisuallyImpairedUserModel(
                disability: user.disability,
                emergencyContact: user.emergencyContact,
                emergencyContactName: user.emergencyContactName,
                recidenceAddress: user.recidenceAddress,
                recidenceCordinate: user.recidenceCordinate,
                guardianId: user.guardianId,
                visitLocation: user.visitLocation)
            .toDocument();

        userCollectionRef.doc(uid).set(userInfo);
      }
      return;
    });
  }

  @override
  Future<String> getCurrentUId() async => auth.currentUser!.uid;
}
