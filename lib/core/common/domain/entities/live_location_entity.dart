import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:visionmate/core/util/classes/cordinates.dart';
import 'package:visionmate/core/util/classes/visit_location.dart';

class LiveLocationEntity extends Equatable {
  final LatLng? liveLocation;
  final bool isAllowedLivelocationShare;

  const LiveLocationEntity(
      {this.liveLocation, this.isAllowedLivelocationShare = false});

  @override
  List<Object?> get props => [liveLocation, isAllowedLivelocationShare];
}
