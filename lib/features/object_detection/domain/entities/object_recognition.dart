import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:visionmate/core/util/classes/cordinates.dart';
import 'package:visionmate/core/util/classes/visit_location.dart';

class ObjectRecognitionEntity extends Equatable {
  final List<dynamic> recognitions;
  final int imageHeight;
  final int imageWidth;

  const ObjectRecognitionEntity(
      {this.recognitions = const [],
      this.imageHeight = 0,
      this.imageWidth = 0});

  @override
  List<Object?> get props => [recognitions, imageHeight, imageWidth];
}
