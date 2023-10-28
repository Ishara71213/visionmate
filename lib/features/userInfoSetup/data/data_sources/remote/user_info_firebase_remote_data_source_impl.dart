import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visionmate/core/constants/user_types.dart';
import 'package:visionmate/core/common/domain/entities/guardian_user_entity.dart';
import 'package:visionmate/core/common/domain/entities/visually_impaired_user_entity.dart';
import 'package:visionmate/core/common/data/models/guardian_user_model.dart';
import 'package:visionmate/core/common/data/models/user_model.dart';
import 'package:visionmate/core/common/data/models/visually_impaired_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:visionmate/features/auth/domain/entities/user_entity.dart';
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

  Future<UserEntity> getCurrentUserById() async {
    CollectionReference userCollectionRef;
    userCollectionRef = firestore.collection("Users");

    final uid = await getCurrentUId();
    UserEntity currentUser = const UserEntity(
        uid: "",
        name: "",
        email: "",
        dob: "",
        status: "",
        userType: UserTypes.visuallyImpairedUser);

    await userCollectionRef.doc(uid).get().then((value) {
      if (value.exists) {
        UserModel user = UserModel.fromSnapshot(value);
        currentUser = UserEntity(
            uid: user.uid,
            name: user.name,
            email: user.email,
            dob: user.dob,
            status: user.status,
            userType: user.userType);
      }
    });
    return currentUser;
  }

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
