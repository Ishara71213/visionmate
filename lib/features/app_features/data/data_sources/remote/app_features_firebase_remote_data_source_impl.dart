import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:visionmate/core/common/domain/entities/guardian_user_entity.dart';
import 'package:visionmate/core/common/domain/entities/user_entity.dart';
import 'package:visionmate/core/common/domain/entities/visually_impaired_user_entity.dart';
import 'package:visionmate/core/common/data/models/guardian_user_model.dart';
import 'package:visionmate/core/common/data/models/user_model.dart';
import 'package:visionmate/core/common/data/models/visually_impaired_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:visionmate/core/constants/user_types.dart';
import 'package:visionmate/features/app_features/data/data_sources/remote/app_features_firebase_remote_data_source.dart';

class AppFeaturesFirebaseRemoteDataSourceImpl
    extends AppFeaturesFirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AppFeaturesFirebaseRemoteDataSourceImpl(
      {required this.auth, required this.firestore});

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

  @override
  Future<UserEntity> updateProfileData(UserEntity entity) async {
    try {
      String? uid = auth.currentUser?.uid;
      CollectionReference userCollectionRef = firestore.collection("Users");

      UserEntity currentUser = const UserEntity(
          uid: "",
          firstName: "",
          lastName: "",
          email: "",
          dob: "",
          status: "",
          imageUrl: "",
          userType: "");

      await userCollectionRef.doc(uid).get().then((value) {
        if (value.exists) {
          UserModel existingUser = UserModel.fromSnapshot(value);
          final userData = UserModel(
                  firstName: entity.firstName ?? existingUser.firstName,
                  lastName: entity.lastName ?? existingUser.lastName,
                  email: entity.email ?? existingUser.email,
                  uid: entity.uid ?? existingUser.uid,
                  dob: entity.dob ?? existingUser.dob,
                  status: entity.status ?? existingUser.status,
                  password: entity.password ?? existingUser.password,
                  imageUrl: entity.imageUrl ?? existingUser.imageUrl,
                  userType: entity.userType ?? existingUser.userType)
              .toDocument();

          currentUser = UserEntity(
              firstName: entity.firstName ?? existingUser.firstName,
              lastName: entity.lastName ?? existingUser.lastName,
              email: entity.email ?? existingUser.email,
              uid: entity.uid ?? existingUser.uid,
              dob: entity.dob ?? existingUser.dob,
              status: entity.status ?? existingUser.status,
              password: entity.password ?? existingUser.password,
              imageUrl: entity.imageUrl ?? existingUser.imageUrl,
              userType: entity.userType ?? existingUser.userType);

          userCollectionRef.doc(uid).set(userData);
        }
      });
      return currentUser;
    } catch (ex) {
      throw ();
    }
  }

  @override
  Future<UserEntity> uploadProfileImage(File image) async {
    try {
      String? uid = auth.currentUser?.uid;
      final path = 'files/profileImages/${uid?.toString()}';
      final ref = FirebaseStorage.instance.ref().child(path);
      UploadTask uploadTask = ref.putFile(image);
      final snapShot = await uploadTask!.whenComplete(() => null);
      final urlDownload = await snapShot.ref.getDownloadURL();

      UserEntity user = UserEntity(imageUrl: urlDownload);
      user = await updateProfileData(user);
      return user;
    } catch (ex) {
      throw ();
    }
  }
}
