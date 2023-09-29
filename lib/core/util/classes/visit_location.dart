import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:visionmate/core/util/classes/cordinates.dart';

class VisitLocation {
  final String? locationName;
  final String? locationPurpose;
  final LatLng? locationCordinates;

  const VisitLocation(
      {this.locationName, this.locationPurpose, this.locationCordinates});
}
