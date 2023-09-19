import 'package:visionmate/core/util/classes/cordinates.dart';

class VisitLocation {
  final String? locationName;
  final String? locationPurpose;
  final Cordinates? locationCordinates;

  const VisitLocation(
      {this.locationName, this.locationPurpose, this.locationCordinates});
}
