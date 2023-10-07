import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visionmate/core/constants/user_types.dart';
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
    // CollectionReference userEmailsCollectionRef;
    userCollectionRef = firestore.collection("Users");
    // userEmailsCollectionRef = firestore.collection("UserEmails");

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
    });

    userCollectionRef = firestore.collection("UserEmails");
    await userCollectionRef.doc(user.email).get().then((value) {
      if (!value.exists) {
        final newUserEmail = UserModel(
          uid: uid,
        ).toDocumentUserEmail();

        userCollectionRef.doc(user.email).set(newUserEmail);
      }
    });
    return;
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
      return;
    });
    return currentUser;
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
