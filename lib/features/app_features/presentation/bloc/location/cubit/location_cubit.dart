import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:visionmate/core/util/classes/visit_location.dart';
import 'package:visionmate/core/widgets/pop_up_dialogs/location_popup_message.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LatLng? residenceLocation;
  String recidenceAddress = "";
  List<VisitLocation> freqVisitingLocations = [];

  LocationCubit() : super(LocationInitial());

  void updateMapCameraView(
      String latitude, String longitude, GoogleMapController controller) {
    double lat = double.parse(latitude);
    double lng = double.parse(longitude);
    emit(LocationDataGathering(curruntLocation: LatLng(lat, lng)));
    controller.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
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
    Position currentLocation = await Geolocator.getCurrentPosition();
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
