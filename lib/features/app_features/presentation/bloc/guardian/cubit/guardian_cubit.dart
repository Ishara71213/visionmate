import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:visionmate/core/common/domain/entities/guardian_user_entity.dart';
import 'package:visionmate/core/common/domain/entities/live_location_entity.dart';
import 'package:visionmate/core/widgets/pop_up_dialogs/location_popup_message.dart';
import 'package:visionmate/features/app_features/domain/usecases/get_current_guardian_info_by_uid_usecase.dart';
import 'package:visionmate/features/app_features/domain/usecases/get_email_by_uid.dart';
import 'package:visionmate/features/app_features/domain/usecases/live_location_data_monitor_usecase.dart';

part 'guardian_state.dart';

class GuardianCubit extends Cubit<GuardianState> {
  final GetCurrentGuardianInfoByUidUsecase getCurrentGuardianUserById;
  final LiveLocationDataMonitotUsecase liveLocationDataMonitotUsecase;
  final GetEmailByUidUsecase getEmailByUidUsecase;
  GuardianUserEntity? userInfo;
  String wardEmail = "";
  LatLng? currentLocationTemp;
  late StreamSubscription<Position> positionStream;
  bool isDisposed = false;

  GuardianCubit(
      {required this.getCurrentGuardianUserById,
      required this.getEmailByUidUsecase,
      required this.liveLocationDataMonitotUsecase})
      : super(GuardianInitial());

  Future<void> resetToInitialState() async {
    emit(GuardianInitial());
  }

  Future<void> getCurrrentUserdata() async {
    try {
      emit(const GuardianDataLoading());
      userInfo = await getCurrentGuardianUserById();
      if (userInfo?.vissuallyImpairedUserId != null) {
        wardEmail = await getEmailByUidUsecase(
            userInfo!.vissuallyImpairedUserId.toString());
      }

      emit(const GuardianDataLoadingComplete());
    } on SocketException catch (_) {
      emit(const GuardianDataLoadingError());
    } catch (_) {
      emit(const GuardianDataLoadingError());
    }
  }

  void updateMapCameraView(
      String latitude, String longitude, GoogleMapController controller) {
    double lat = double.parse(latitude);
    double lng = double.parse(longitude);
    currentLocationTemp = LatLng(lat, lng);
    emit(GuardianLocationDataGathering(curruntLocation: LatLng(lat, lng)));
    controller.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
  }

  void updateCurrentLocation(
      String wardId, GoogleMapController controller) async {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.low,
      distanceFilter: 0,
    );
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) async {
      if (position != null) {
        LiveLocationEntity liveLocationMonitor =
            await liveLocationDataMonitotUsecase(wardId);
        emit(LiveLocationDataMonitoring(
          curruntLocation: LatLng(position.latitude, position.longitude),
          wardLocation: LatLng(liveLocationMonitor?.liveLocation?.latitude ?? 0,
              liveLocationMonitor?.liveLocation?.longitude ?? 0),
        ));
        if (!isDisposed) {
          controller.animateCamera(CameraUpdate.newLatLng(LatLng(
              liveLocationMonitor.liveLocation?.latitude ?? 0,
              liveLocationMonitor.liveLocation?.longitude ?? 0)));
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
    Position currentLocation = await Geolocator.getCurrentPosition();

    emit(GuardianLocationDataGathering(
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
