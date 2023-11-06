import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:visionmate/core/common/domain/entities/live_location_entity.dart';
import 'package:visionmate/core/constants/secret_api_keys.dart';
import 'package:visionmate/core/util/classes/visit_location.dart';
import 'package:visionmate/core/util/functions/text_to_speech_helper.dart';
import 'package:visionmate/core/widgets/pop_up_dialogs/location_popup_message.dart';
import 'package:visionmate/features/app_features/domain/usecases/live_location_usecase.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LiveLocationDataUsecase liveLocationDataUsecase;

  LatLng? residenceLocation;
  String recidenceAddress = "";
  List<VisitLocation> freqVisitingLocations = [];
  LatLng destinationLoc = const LatLng(0, 0);
  LatLng startLoc = const LatLng(0, 0);
  LatLng currentLoc = const LatLng(0, 0);
  // final Set<Marker> markers = new Set();
  List<LatLng> polylineCordinates = [];
  late StreamSubscription<Position> positionStream;
  bool isDisposed = false;

  LocationCubit({required this.liveLocationDataUsecase})
      : super(LocationInitial());

  void dispose() {
    isDisposed = true;
    emit(LocationInitial());
    polylineCordinates = [];
    //positionStream.pause();
  }

  Future<void> getPolyLinePoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        GOOGLE_API_KEY,
        PointLatLng(startLoc.latitude, startLoc.longitude),
        PointLatLng(destinationLoc.latitude, destinationLoc.longitude));
    polylineCordinates = [];
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCordinates.add(LatLng(point.latitude, point.longitude));
      });
      Future.delayed(const Duration(seconds: 2), () {
        textToSpeech(
            "${result.distance.toString()} to the destination and it will take ${result.duration.toString()} to travel");
      });
    }
  }

  void updateMapCameraView(
      String latitude, String longitude, GoogleMapController controller) {
    double lat = double.parse(latitude);
    double lng = double.parse(longitude);
    emit(LocationDataGathering(curruntLocation: LatLng(lat, lng)));
    controller.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
  }

  void setDestinationAndStartLocation(VisitLocation location) async {
    double lat = location.locationCordinates?.latitude ?? 0;
    double lng = location.locationCordinates?.longitude ?? 0;
    destinationLoc = LatLng(lat, lng);
    startLoc = LatLng(currentLoc.latitude, currentLoc.longitude);

    polylineCordinates = [];
    emit(LocationDataGathering(curruntLocation: currentLoc));

    await getPolyLinePoints();
    //***********only send the current location emmit if some thing goes wrong it will work fine then
    emit(LocationStartDirections(
        polylineCordinates: polylineCordinates,
        startLocation: LatLng(currentLoc.latitude, currentLoc.longitude),
        curruntLocation: LatLng(currentLoc.latitude, currentLoc.longitude),
        destinationLocation: LatLng(lat, lng)));
    // controller.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
  }

  void updateCurrentLocation(GoogleMapController controller) async {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.low,
      distanceFilter: 0,
    );
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      if (position != null) {
        var count = 0;
        if (count % 25 == 0) {
          LiveLocationEntity liveLocationEntity = LiveLocationEntity(
              isAllowedLivelocationShare: true,
              liveLocation: LatLng(position.latitude, position.longitude));
          liveLocationDataUsecase(liveLocationEntity);
        }
        count++;
        emit(LocationStartDirections(
            polylineCordinates: polylineCordinates,
            curruntLocation: LatLng(position.latitude, position.longitude),
            startLocation: LatLng(position.latitude, position.longitude),
            destinationLocation:
                LatLng(destinationLoc.latitude, destinationLoc.longitude)));
        if (!isDisposed) {
          controller.animateCamera(CameraUpdate.newLatLng(
              LatLng(position.latitude, position.longitude)));
        }
      }
      print(position == null
          ? 'Unknown'
          : 'live ${position.latitude.toString()}, ${position.longitude.toString()}');
    });
  }

  void determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position? lastKNownPosition = await Geolocator.getLastKnownPosition();
    Position? currentLocation =
        await Geolocator.getCurrentPosition().then((value) {
      currentLoc = LatLng(value.latitude, value.longitude);
      return value;
    }).catchError((err) {
      if (lastKNownPosition != null) {
        currentLoc =
            LatLng(lastKNownPosition.latitude, lastKNownPosition.longitude);
        emit(LocationDataGathering(
            curruntLocation: LatLng(
                lastKNownPosition.latitude, lastKNownPosition.longitude)));
        return lastKNownPosition;
      }
    });
    currentLoc = LatLng(currentLocation.latitude, currentLocation.longitude);

    emit(LocationDataGathering(
        curruntLocation:
            LatLng(currentLocation.latitude, currentLocation.longitude)));
  }

  void checkIsLocationServiceEnabled(BuildContext context) async {
    bool serviceEnabled;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      WidgetsBinding.instance?.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const LocationPopUp();
          },
        );
      });
    }
  }
}
