import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:visionmate/core/util/classes/cordinates.dart';
import 'package:visionmate/core/util/classes/visit_location.dart';

class VisuallyImpairedUserEntity extends Equatable {
  final String? disability;
  final String? emergencyContact;
  final String? emergencyContactName;
  final String? recidenceAddress;
  final LatLng? recidenceCordinate;
  final String? guardianId;
  final List<VisitLocation>? visitLocation;
  final bool isAllowedLivelocationShare;

  const VisuallyImpairedUserEntity(
      {this.disability,
      this.emergencyContact,
      this.emergencyContactName,
      this.recidenceAddress,
      this.recidenceCordinate,
      this.guardianId,
      this.visitLocation,
      this.isAllowedLivelocationShare = false});

  @override
  List<Object?> get props => [
        disability,
        emergencyContact,
        emergencyContactName,
        recidenceAddress,
        recidenceCordinate,
        guardianId,
        visitLocation,
        isAllowedLivelocationShare
      ];
}
