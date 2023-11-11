import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:visionmate/core/common/domain/entities/live_location_entity.dart';

class LiveLocationModel extends LiveLocationEntity {
  const LiveLocationModel(
      {final LatLng? liveLocation,
      final bool isAllowedLivelocationShare = false})
      : super(
            liveLocation: liveLocation,
            isAllowedLivelocationShare: isAllowedLivelocationShare);

  factory LiveLocationModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    dynamic templiveLocationCordinate = documentSnapshot.get("liveLocation");

    LatLng? liveLocationCordinate = (templiveLocationCordinate != null)
        ? LatLng(documentSnapshot.get("liveLocation")['latitude'] ?? 0.0,
            documentSnapshot.get("liveLocation")['longitude'] ?? 0.0)
        : null;
    return LiveLocationModel(
      liveLocation: liveLocationCordinate,
      isAllowedLivelocationShare:
          documentSnapshot.get("isAllowedLivelocationShare"),
    );
  }

  Map<String, dynamic> toDocument() {
    Map<String, dynamic> cordinate = {
      "latitude": liveLocation?.latitude,
      "longitude": liveLocation?.longitude,
    };
    return {
      "liveLocation": cordinate,
      "isAllowedLivelocationShare": isAllowedLivelocationShare,
    };
  }
}
