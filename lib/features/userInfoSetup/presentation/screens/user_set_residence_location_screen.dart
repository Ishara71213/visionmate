// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:visionmate/core/constants/secret_api_keys.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/widgets/input_widgets/input_widgets_library.dart';
import 'package:visionmate/features/app_features/presentation/bloc/viuser/cubit/viuser_cubit.dart';
import 'package:visionmate/features/userInfoSetup/presentation/bloc/user_info/cubit/user_info_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

class UserSetResidenceLocationScreen extends StatefulWidget {
  final dynamic data;
  const UserSetResidenceLocationScreen({super.key, required this.data});

  @override
  State<UserSetResidenceLocationScreen> createState() =>
      _UserSetResidenceLocationScreenState();
}

class _UserSetResidenceLocationScreenState
    extends State<UserSetResidenceLocationScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final TextEditingController _locationSearchController =
      TextEditingController();

  @override
  void dispose() {
    _locationSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final bool isAccessingFromSettings =
        widget.data?['isAccessingFromSettings'] ?? false;
    if (_locationSearchController.text == "") {
      _locationSearchController.text =
          widget.data?['emergencyContactName'] ?? "";
    }
    LatLng currentLocation = const LatLng(6.8393012, 79.9003934);
    UserInfoCubit userInfoCubit = BlocProvider.of<UserInfoCubit>(context);
    return BlocListener<UserInfoCubit, UserInfoState>(
      listener: (context, state) async {
        // if (state is UserInfoInitial) {
        //   userInfoCubit.checkIsLocationServiceEnabled(context);
        //   userInfoCubit.determinePosition();
        // }
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 90.0,
                      ),
                      Stack(
                        children: [
                          SizedBox(
                            height: size.height - 256,
                            child: BlocBuilder<UserInfoCubit, UserInfoState>(
                              builder: (context, state) {
                                if (state is UserInfoInitial) {
                                  userInfoCubit
                                      .checkIsLocationServiceEnabled(context);
                                  userInfoCubit.determinePosition();
                                } else if (state
                                    is UserInfoLocationDataGathering) {
                                  currentLocation = state.curruntLocation;
                                  _controller.future
                                      .then((GoogleMapController controller) {
                                    // The GoogleMapController is ready, you can call methods on it here.
                                    userInfoCubit.updateMapCameraView(
                                        state.curruntLocation.latitude
                                            .toString(),
                                        state.curruntLocation.longitude
                                            .toString(),
                                        controller);
                                  });
                                } else {
                                  currentLocation = const LatLng(
                                      37.42796133580664, -122.085749655962);
                                }
                                return GoogleMap(
                                  onTap: (argument) =>
                                      FocusScope.of(context).unfocus(),
                                  myLocationEnabled: true,
                                  myLocationButtonEnabled: false,
                                  zoomControlsEnabled: false,
                                  mapType: MapType.normal,
                                  initialCameraPosition: CameraPosition(
                                    target: currentLocation,
                                    zoom: 16.4746,
                                  ),
                                  markers: {
                                    Marker(
                                      markerId:
                                          const MarkerId('currentLocation'),
                                      position: currentLocation,
                                      infoWindow: const InfoWindow(
                                          title: 'Current Location'),
                                    ),
                                  },
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _controller.complete(controller);
                                  },
                                );
                              },
                            ),
                          ),
                          !isAccessingFromSettings
                              ? SizedBox(
                                  height: size.height - 256,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: FilledButton(
                                            onPressed: () {
                                              userInfoCubit.residenceLocation =
                                                  currentLocation;
                                              navigationHandler(
                                                  context,
                                                  RouteConst
                                                      .setfreqVisitingLocScreen);
                                            },
                                            style: FilledButton.styleFrom(
                                                minimumSize:
                                                    const Size.fromHeight(60),
                                                backgroundColor:
                                                    kButtonPrimaryColor,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.0))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.add_circle),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text("Add Location",
                                                    style:
                                                        kFilledButtonTextstyle),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 14.0),
                            child: Column(
                              children: [
                                GooglePlaceAutoCompleteTextField(
                                  boxDecoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.5, color: kLightGreyColor),
                                      color: kAppBgColor.withOpacity(0.92),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  textEditingController:
                                      _locationSearchController,
                                  googleAPIKey: GOOGLE_API_KEY,
                                  inputDecoration: InputDecoration(
                                    hintText: "Search Location",
                                    hintStyle: kInputFieldHintText,
                                    border: InputBorder.none,
                                  ),
                                  debounceTime: 800, // default 600 ms,
                                  //countries: ["in","fr"],// optional by default null is set
                                  isLatLngRequired:
                                      true, // if you required coordinates from place detail
                                  getPlaceDetailWithLatLng:
                                      (Prediction prediction) {
                                    // this method will return latlng with place detail

                                    _controller.future
                                        .then((GoogleMapController controller) {
                                      // The GoogleMapController is ready, you can call methods on it here.
                                      userInfoCubit.updateMapCameraView(
                                          prediction.lat.toString(),
                                          prediction.lng.toString(),
                                          controller);
                                    });
                                    userInfoCubit.residenceLocation = LatLng(
                                        double.parse(
                                            prediction?.lat.toString() ?? "0"),
                                        double.parse(
                                            prediction?.lng.toString() ?? "0"));
                                    print("placeDetails" +
                                        prediction.lng.toString());
                                  }, // this callback is called when isLatLngRequired is true
                                  itemClick: (Prediction prediction) {
                                    userInfoCubit.recidenceAddress =
                                        prediction.description.toString();
                                    _locationSearchController.text =
                                        prediction.description.toString();
                                    _locationSearchController.selection =
                                        TextSelection.fromPosition(TextPosition(
                                            offset: prediction
                                                .description!.length));
                                  },
                                  // if we want to make custom list item builder
                                  itemBuilder:
                                      (context, index, Prediction prediction) {
                                    return Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.location_on),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          Expanded(
                                              child: Text(
                                                  prediction.description ?? ""))
                                        ],
                                      ),
                                    );
                                  },
                                  // if you want to add seperator between list items
                                  seperatedBuilder: const Divider(),
                                  // want to show close icon
                                  isCrossBtnShown: true,
                                ),
                                const SizedBox(
                                  height: 8,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: kAppBgColor,
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: kPrimaryColor,
                        ),
                        iconSize: 30,
                        splashRadius: 1,
                        padding: const EdgeInsets.only(
                            left: 22, right: 6, bottom: 10),
                      ),
                      Flexible(
                          child: Text(
                        'Setup your Residence Location',
                        style: kOnboardScreenTitle,
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: !isAccessingFromSettings
            ? Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Skip",
                          style: kBluetextStyle,
                        )),
                    OutlinedButton(
                      onPressed: () {
                        navigationHandler(
                            context, RouteConst.setfreqVisitingLocScreen);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: kPrimaryColor),
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10),
                        primary: kPrimaryColor,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                            color: kPrimaryColor, shape: BoxShape.circle),
                        child: Icon(
                          Icons.navigate_next,
                          size: 40,
                          color: kLightGreyColor,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: FilledButton(
                    onPressed: () async {
                      if (_locationSearchController.text != "" ||
                          userInfoCubit.residenceLocation?.latitude != 0) {
                        await userInfoCubit.submitResidenceLocatinField();
                        BlocProvider.of<ViuserCubit>(context)
                            .getCurrrentUserdata();
                      }
                    },
                    style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(60),
                        backgroundColor: kButtonPrimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0))),
                    child: Text("Save", style: kFilledButtonTextstyle)),
              ),
      ),
    );
  }
}
