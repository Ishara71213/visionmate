import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:visionmate/core/util/classes/cordinates.dart';
import 'package:visionmate/core/util/classes/visit_location.dart';

class GuardianUserEntity extends Equatable {
  final String? vissuallyImpairedUserId;
  final bool isAllowedLivelocationShare;

  const GuardianUserEntity(
      {this.vissuallyImpairedUserId, this.isAllowedLivelocationShare = false});

  @override
  List<Object?> get props =>
      [vissuallyImpairedUserId, isAllowedLivelocationShare];
}
