import 'dart:ffi';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visionmate/core/entities/guardian_user_entity.dart';
import 'package:visionmate/core/entities/visually_impaired_user_entity.dart';
import 'package:visionmate/core/util/classes/visit_location.dart';
import 'package:visionmate/core/widgets/pop_up_dialogs/location_popup_message.dart';
import 'package:visionmate/features/userInfoSetup/domain/usecases/create_current_guardian_user_type_info_usecase.dart';
import 'package:visionmate/features/userInfoSetup/domain/usecases/create_current_vi_user_type_info_usecase.dart';
import 'package:visionmate/features/userInfoSetup/domain/usecases/get_current_uid_usecase.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:visionmate/features/userInfoSetup/domain/usecases/get_uid_by_email.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  final CreateCurrentViUserTypeInfo createCurrentViUserTypeInfo;
  final GetCurrentUIdGlobalUsecase getCurrentUIdUsecase;
  final GetUIdByEmailUsecase getUIdEmailUsecase;
  final CreateCurrentguardianUserTypeInfo createCurrentguardianUserTypeInfo;

  String errorMsg = "";
  String emergencyContactName = "";
  String emergencyContact = "";
  String disabilityInfo = "";
  LatLng? residenceLocation;
  String recidenceAddress = "";
  LatLng? freqVisitLocationTemp;
  List<VisitLocation> freqVisitingLocations = [];
  String assignerEmail = "";
  String assignerId = "";

  bool isAllowedLivelocationShare = false;

  UserInfoCubit(
      {required this.createCurrentViUserTypeInfo,
      required this.createCurrentguardianUserTypeInfo,
      required this.getCurrentUIdUsecase,
      required this.getUIdEmailUsecase})
      : super(UserInfoInitial());

  Future<void> resetToInitialState() async {
    emit(UserInfoInitial());
  }

  void updateMapCameraView(
      String latitude, String longitude, GoogleMapController controller) {
    double lat = double.parse(latitude);
    double lng = double.parse(longitude);
    freqVisitLocationTemp = LatLng(lat, lng);
    emit(UserInfoLocationDataGathering(curruntLocation: LatLng(lat, lng)));
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
    emit(UserInfoLocationDataGathering(
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

  void addFeqVisitLocationsToList(String locationName, String locationPurpose) {
    freqVisitingLocations.add(VisitLocation(
        locationName: locationName,
        locationPurpose: locationPurpose,
        locationCordinates: freqVisitLocationTemp));
  }

  Future<void> verifyGuardian() async {
    String uid = "";
    emit(UserInfoLinkUserLoading());
    try {
      uid = await getUIdEmailUsecase.call(assignerEmail);
      if (uid != "") {
        assignerId = uid;
        emit(UserInfoLinkUserSuccess());
      } else {
        errorMsg = "User not available";
        emit(UserInfoLinkUserFailrue());
      }
    } on SocketException catch (_) {
      emit(UserInfoLinkUserFailrue());
    } catch (e) {
      final error = e.toString();
      errorMsg = error.split(']').last;
      emit(UserInfoLinkUserFailrue());
    }
  }

  void removeAssignUser() {
    assignerEmail = "";
    assignerId = "";
    emit(UserInfoLinkUser());
  }

  Future<void> submitViUserInfo() async {
    VisuallyImpairedUserEntity user = VisuallyImpairedUserEntity(
        disability: disabilityInfo,
        emergencyContact: emergencyContact,
        emergencyContactName: emergencyContactName,
        recidenceAddress: recidenceAddress,
        recidenceCordinate: residenceLocation,
        guardianId: assignerId,
        visitLocation: freqVisitingLocations,
        isAllowedLivelocationShare: isAllowedLivelocationShare);

    emit(UserInfoLoading());
    try {
      await createCurrentViUserTypeInfo.call(user);
      emit(UserInfoSuccess());
    } on SocketException catch (_) {
      emit(UserInfoFailrue());
    } catch (e) {
      final error = e.toString();
      errorMsg = error.split(']').last;
      emit(UserInfoFailrue());
    }
  }

  Future<void> submitGuardianUserInfo() async {
    GuardianUserEntity user = GuardianUserEntity(
        vissuallyImpairedUserId: assignerId,
        isAllowedLivelocationShare: isAllowedLivelocationShare);
    emit(UserInfoLoading());
    try {
      await createCurrentguardianUserTypeInfo.call(user);
      emit(UserInfoSuccess());
    } on SocketException catch (_) {
      emit(UserInfoFailrue());
    } catch (e) {
      final error = e.toString();
      errorMsg = error.split(']').last;
      emit(UserInfoFailrue());
    }
  }
}
