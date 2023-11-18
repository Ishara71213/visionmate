import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floor/floor.dart';
import 'package:intl/intl.dart';
import 'package:visionmate/features/volenteer_support/data/data_sources/remote/volunteer_support_remote_data_source.dart';
import 'package:visionmate/features/volenteer_support/data/model/volunteer_request_model.dart';
import 'package:visionmate/features/volenteer_support/domain/entities/volenteer_request_entity.dart';

class VolunteerSupportRemoteDataSourceImpl
    extends VolunteerSupportRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  VolunteerSupportRemoteDataSourceImpl(
      {required this.auth, required this.firestore});

  @override
  Future<List<VolunteerRequestEntity>> getAllRequest() async {
    CollectionReference requestCollectionRef =
        firestore.collection("volunteerRequest");
    List<VolunteerRequestEntity> requestList = [];

    try {
      await requestCollectionRef.get().then((value) {
        value.docs.forEach((element) {
          final VolunteerRequestModal request =
              VolunteerRequestModal.fromSnapshot(element);
          VolunteerRequestEntity requestEntity = VolunteerRequestEntity(
              requestId: request.requestId,
              title: request.title,
              content: request.content,
              imageUrl: request.imageUrl,
              createdUserId: request.createdUserId,
              acceptedUserUserId: request.acceptedUserUserId,
              createdUserImageUrl: request.createdUserImageUrl,
              acceptedUserImageUrl: request.acceptedUserImageUrl,
              acceptedUserName: request.acceptedUserName,
              createdUser: request.createdUser);

          // fetch inverse Order
          requestList.insert(0, requestEntity);
        });
      });
      return requestList;
    } catch (ex) {
      throw ();
    }
  }

  @override
  Future<VolunteerRequestEntity> getRequestById(String requestId) {
    // TODO: implement getRequestById
    throw UnimplementedError();
  }

  @override
  Future<bool> submitRequest(VolunteerRequestEntity entity) async {
    CollectionReference requestCollectionRef =
        firestore.collection("volunteerRequest");
    try {
      final uid = auth.currentUser!.uid;
      final now = DateTime.now();
      final String fileName =
          '${DateFormat('yyyyMMddHHmmss').format(now)}${uid?.toString()}';
      await requestCollectionRef.doc(fileName).get().then((value) {
        if (value.exists) {
          return false;
        }
        final request = VolunteerRequestModal(
                requestId: fileName,
                title: entity.title,
                content: entity.content,
                imageUrl: entity.imageUrl,
                createdUser: entity.createdUser,
                createdUserImageUrl: entity.createdUserImageUrl,
                acceptedUserName: entity.acceptedUserName,
                acceptedUserImageUrl: entity.acceptedUserImageUrl,
                acceptedUserUserId: entity.acceptedUserUserId,
                createdDate: DateTime.now(),
                createdUserId: uid)
            .toDocument();
        requestCollectionRef.doc(fileName).set(request);
      });
      return true;
    } catch (ex) {
      throw ();
    }
  }

  @override
  Future<bool> deleteRequestById(String requestId) async {
    try {
      CollectionReference requestCollectionRef =
          firestore.collection("volunteerRequest");
      await requestCollectionRef.doc(requestId).delete();
      return true;
    } catch (ex) {
      throw ();
    }
  }

  @override
  Future<bool> acceptRequestById(VolunteerRequestEntity entity) async {
    CollectionReference requestCollectionRef =
        firestore.collection("volunteerRequest");
    try {
      await requestCollectionRef.doc(entity.requestId).update({
        'acceptedUserName': entity.acceptedUserName,
        'acceptedUserUserId': entity.acceptedUserUserId,
        'acceptedUserImageUrl': entity.acceptedUserImageUrl,
      });
      return true;
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<bool> rejectRequestById(String requestId) {
    // TODO: implement rejectRequestById
    throw UnimplementedError();
  }
}
