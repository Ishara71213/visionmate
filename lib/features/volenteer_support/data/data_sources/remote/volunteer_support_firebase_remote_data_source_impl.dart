import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:visionmate/features/volenteer_support/data/data_sources/remote/volunteer_suport_firebase_remote_data_source.dart';
import 'package:visionmate/features/volenteer_support/domain/entities/volenteer_request_entity.dart';

class VounteerSupportFirebaseRemoteDataSourceImpl
    extends VounteerSupportFirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  VounteerSupportFirebaseRemoteDataSourceImpl(
      {required this.auth, required this.firestore});

  @override
  Future<List<VolunteerRequestEntity>> getAllRequest() {
    // TODO: implement getAllRequest
    throw UnimplementedError();
  }

  @override
  Future<VolunteerRequestEntity> getRequestById(String requestId) {
    // TODO: implement getRequestById
    throw UnimplementedError();
  }

  @override
  Future<bool> submitRequest(VolunteerRequestEntity entity) {
    // TODO: implement submitRequest
    throw UnimplementedError();
  }

  // @override
  // Future<List<VolunteerRequestEntity>> getAllRequest() async {
  //   CollectionReference postCollectionRef =
  //       firestore.collection("communityPosts");
  //   List<PostEntity> postList = [];

  //   try {
  //     await postCollectionRef.get().then((value) {
  //       value.docs.forEach((element) {
  //         final PostModal post = PostModal.fromSnapshot(element);
  //         PostEntity postEntity = PostEntity(
  //             title: post.title,
  //             content: post.content,
  //             imageUrl: post.imageUrl,
  //             createdUserId: post.createdUserId,
  //             createdUser: post.createdUser);
  //         //postList.add(postEntity);
  //         // fetch inverse Order
  //         postList.insert(0, postEntity);
  //       });
  //     });
  //     return postList;
  //   } catch (ex) {
  //     throw ();
  //   }
  // }

  // @override
  // Future<bool> submitPost(PostEntity entity) async {
  //   CollectionReference postCollectionRef =
  //       firestore.collection("communityPosts");
  //   try {
  //     final uid = auth.currentUser!.uid;
  //     final now = DateTime.now();
  //     final String fileName =
  //         '${DateFormat('yyyyMMddHHmmss').format(now)}${uid?.toString()}';
  //     await postCollectionRef.doc(fileName).get().then((value) {
  //       if (value.exists) {
  //         return false;
  //       }
  //       final post = PostModal(
  //               title: entity.title,
  //               content: entity.content,
  //               imageUrl: entity.imageUrl,
  //               createdUser: entity.createdUser,
  //               createdDate: DateTime.now(),
  //               createdUserId: uid)
  //           .toDocument();
  //       postCollectionRef.doc(fileName).set(post);
  //     });
  //     return true;
  //   } catch (ex) {
  //     throw ();
  //   }
  // }
}
