import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:visionmate/core/entities/visually_impaired_user_entity.dart';
import 'package:visionmate/core/util/classes/cordinates.dart';
import 'package:visionmate/core/util/classes/visit_location.dart';

class VisuallyImpairedUserModel extends VisuallyImpairedUserEntity {
  const VisuallyImpairedUserModel(
      {final String? disability,
      final String? emergencyContact,
      final String? emergencyContactName,
      final String? recidenceAddress,
      final LatLng? recidenceCordinate,
      final String? guardianId,
      final List<VisitLocation>? visitLocation,
      final bool isAllowedLivelocationShare = false})
      : super(
            disability: disability,
            emergencyContact: emergencyContact,
            emergencyContactName: emergencyContactName,
            recidenceAddress: recidenceAddress,
            recidenceCordinate: recidenceCordinate,
            guardianId: guardianId,
            visitLocation: visitLocation,
            isAllowedLivelocationShare: isAllowedLivelocationShare);

  factory VisuallyImpairedUserModel.fromSnapshot(
      DocumentSnapshot documentSnapshot) {
    List<dynamic>? visitLocationData =
        documentSnapshot.get("visitLocation") as List<dynamic>?;
    List<VisitLocation>? visitLocation =
        (visitLocationData ?? []).map((locationData) {
      final locationCoordinatesData =
          locationData['locationCordinates'] as Map<String, dynamic>?;
      return VisitLocation(
        locationName: locationData['locationName'] as String?,
        locationPurpose: locationData['locationPurpose'] as String?,
        locationCordinates: (locationCoordinatesData != null)
            ? LatLng(
                locationCoordinatesData['latitude'] as double? ?? 0.0,
                locationCoordinatesData['longitude'] as double? ?? 0.0,
              )
            : null,
      );
    }).toList();

    dynamic tempResidenceCordinate = documentSnapshot.get("recidenceCordinate");

    LatLng? residenceCordinate = (tempResidenceCordinate != null)
        ? LatLng(documentSnapshot.get("recidenceCordinate")['latitude'] ?? 0.0,
            documentSnapshot.get("recidenceCordinate")['longitude'] ?? 0.0)
        : null;

    return VisuallyImpairedUserModel(
        disability: documentSnapshot.get("disability"),
        emergencyContact: documentSnapshot.get("emergencyContact"),
        emergencyContactName: documentSnapshot.get("emergencyContactName"),
        recidenceAddress: documentSnapshot.get("recidenceAddress"),
        recidenceCordinate: residenceCordinate,
        guardianId: documentSnapshot.get("guardianId"),
        visitLocation: visitLocation,
        isAllowedLivelocationShare:
            documentSnapshot.get("isAllowedLivelocationShare"));
  }

  Map<String, dynamic> toDocument() {
    List<Map<String, dynamic>> visitLocationList = (visitLocation != null)
        ? visitLocation!.map((visitLocation) {
            return {
              "locationName": visitLocation.locationName,
              "locationPurpose": visitLocation.locationPurpose,
              "locationCordinates": {
                "latitude": visitLocation.locationCordinates?.latitude,
                "longitude": visitLocation.locationCordinates?.longitude,
              },
            };
          }).toList()
        : [];

    Map<String, dynamic> cordinate = {
      "latitude": recidenceCordinate?.latitude,
      "longitude": recidenceCordinate?.longitude,
    };

    return {
      "disability": disability,
      "emergencyContact": emergencyContact,
      "emergencyContactName": emergencyContactName,
      "recidenceAddress": recidenceAddress,
      "recidenceCordinate": cordinate,
      "guardianId": guardianId,
      "visitLocation": visitLocationList,
      "isAllowedLivelocationShare": isAllowedLivelocationShare,
    };
  }
}
