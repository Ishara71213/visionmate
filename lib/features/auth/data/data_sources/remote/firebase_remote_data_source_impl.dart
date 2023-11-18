import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visionmate/core/constants/user_types.dart';
import 'package:visionmate/core/common/data/models/user_model.dart';
import 'package:visionmate/core/common/domain/entities/user_entity.dart';
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
                firstName: user.firstName,
                lastName: user.lastName,
                email: user.email,
                dob: user.dob,
                status: user.status,
                imageUrl: user.imageUrl,
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
  }

  @override
  Future<UserEntity> getCurrentUserById() async {
    CollectionReference userCollectionRef;
    userCollectionRef = firestore.collection("Users");

    final uid = await getCurrentUId();
    UserEntity currentUser = const UserEntity(
        uid: "",
        firstName: "",
        lastName: "",
        email: "",
        dob: "",
        imageUrl: "",
        status: "",
        userType: UserTypes.visuallyImpairedUser);

    await userCollectionRef.doc(uid).get().then((value) {
      if (value.exists) {
        UserModel user = UserModel.fromSnapshot(value);
        currentUser = UserEntity(
            uid: user.uid,
            firstName: user.firstName,
            lastName: user.lastName,
            email: user.email,
            dob: user.dob,
            status: user.status,
            imageUrl: user.imageUrl,
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
