import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visionmate/core/models/user_model.dart';
import 'package:visionmate/features/auth/domain/entities/user_entity.dart';
import 'package:visionmate/features/auth/data/data_sources/remote/firebase_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRemoteDataSourceImpl extends FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseRemoteDataSourceImpl({required this.auth, required this.firestore});

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    CollectionReference userCollectionRef;
    userCollectionRef = firestore.collection("Users");

    final uid = await getCurrentUId();

    await userCollectionRef.doc(uid).get().then((value) {
      if (!value.exists) {
        final newUser = UserModel(
                uid: uid,
                name: user.name,
                email: user.email,
                dob: user.dob,
                status: user.status,
                userType: user.userType)
            .toDocument();

        userCollectionRef.doc(uid).set(newUser);
      }
      return;
    });
    // CollectionReference userCollectionRef;
    // CollectionReference userTypeCollectionRef;
    // if (user.userType == "Volunteer") {
    //   userTypeCollectionRef = firestore.collection("Volunteers");
    // } else if (user.userType == "Guardian") {
    //   userTypeCollectionRef = firestore.collection("Guardians");
    // } else {
    //   userTypeCollectionRef = firestore.collection("VisuallyImpairedUsers");
    // }

    // final uid = await getCurrentUId();

    // await userTypeCollectionRef.doc(uid).get().then((value) {
    //   if (!value.exists) {
    //     final newUser = UserModel(
    //             uid: uid,
    //             name: user.name,
    //             email: user.email,
    //             dob: user.dob,
    //             status: user.status,
    //             userType: user.userType)
    //         .toDocument();

    //     userTypeCollectionRef.doc(uid).set(newUser);
    //   }
    //   //return;
    // });

    // userCollectionRef = firestore.collection("Users");
    // await userCollectionRef.doc(uid).get().then((value) {
    //   if (!value.exists) {
    //     final newUser = UserModel(userType: user.userType).toDocumentUserType();

    //     userCollectionRef.doc(uid).set(newUser);
    //   }
    //   return;
    // });
  }

  @override
  Future<String> getCurrentUId() async => auth.currentUser!.uid;

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signIn(UserEntity user) async => auth.signInWithEmailAndPassword(
      email: user.email!, password: user.password!);

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> signUp(UserEntity user) async =>
      await auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);
}
