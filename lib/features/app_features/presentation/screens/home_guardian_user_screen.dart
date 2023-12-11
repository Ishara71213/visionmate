import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/common/presentation/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:visionmate/features/app_features/presentation/bloc/guardian/cubit/guardian_cubit.dart';
import 'package:visionmate/features/app_features/presentation/bloc/profile/profile_cubit.dart';
import 'package:visionmate/features/app_features/presentation/widgets/common_app_bar.dart';
import 'package:visionmate/features/app_features/presentation/widgets/guardian_default_screen.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:lottie/lottie.dart' as li;

class HomeGuardianUserScreen extends StatefulWidget {
  const HomeGuardianUserScreen({super.key});

  @override
  State<HomeGuardianUserScreen> createState() => _HomeGuardianUserScreenState();
}

class _HomeGuardianUserScreenState extends State<HomeGuardianUserScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  @override
  Widget build(BuildContext context) {
    UserCubit userCubit = BlocProvider.of<UserCubit>(context);
    GuardianCubit guardianCubit = BlocProvider.of<GuardianCubit>(context);
    Size size = MediaQuery.of(context).size;
    LatLng currentLocation = const LatLng(6.8393012, 79.9003934);
    return GestureDetector(
      onLongPress: () {
        BlocProvider.of<SpeechToTextCubit>(context).listning(context);
      },
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                  padding: EdgeInsets.all(8.0), child: CommonAppBar()),
              const SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  Column(
                    children: [
                      BlocProvider.of<GuardianCubit>(context).wardEmail == ""
                          ? const Padding(
                              padding: EdgeInsets.all(18.0),
                              child: GuardianDefaultView(),
                            )
                          : SizedBox(
                              height: size.height - 256,
                              child: BlocBuilder<GuardianCubit, GuardianState>(
                                builder: (context, state) {
                                  if (state is GuardianDataLoadingComplete) {
                                    guardianCubit
                                        .checkIsLocationServiceEnabled(context);
                                    guardianCubit.determinePosition();
                                  } else if (state
                                      is GuardianLocationDataGathering) {
                                    currentLocation = state.curruntLocation;
                                    _controller.future
                                        .then((GoogleMapController controller) {
                                      // The GoogleMapController is ready, you can call methods on it here.
                                      guardianCubit.updateCurrentLocation(
                                          BlocProvider.of<GuardianCubit>(
                                                      context)
                                                  ?.userInfo
                                                  ?.vissuallyImpairedUserId ??
                                              "",
                                          controller);
                                      // guardianCubit.updateMapCameraView(
                                      //     state.curruntLocation.latitude.toString(),
                                      //     state.curruntLocation.longitude
                                      //         .toString(),
                                      //     controller);
                                    });
                                  } else if (state
                                      is LiveLocationDataMonitoring) {
                                    currentLocation = state.curruntLocation;
                                    _controller.future
                                        .then((GoogleMapController controller) {
                                      print(state.curruntLocation.latitude
                                              .toString() +
                                          "   " +
                                          state.curruntLocation.longitude
                                              .toString());
                                      // The GoogleMapController is ready, you can call methods on it here.
                                      guardianCubit.updateCurrentLocation(
                                          BlocProvider.of<GuardianCubit>(
                                                      context)
                                                  ?.userInfo
                                                  ?.vissuallyImpairedUserId ??
                                              "",
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
                                        position:
                                            state is LiveLocationDataMonitoring
                                                ? state.curruntLocation
                                                : const LatLng(0, 0),
                                        infoWindow: const InfoWindow(
                                            title: 'Current Location'),
                                      ),
                                      Marker(
                                        markerId:
                                            const MarkerId('startLocation'),
                                        position:
                                            state is LiveLocationDataMonitoring
                                                ? state.wardLocation
                                                : const LatLng(0, 0),
                                        infoWindow: const InfoWindow(
                                            title: 'Start Location'),
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
                    ],
                  ),
                  SizedBox(
                    height: size.height - 256,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        guardianCubit.isliveLocationMonitering
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: kLightGreyColor,
                                          borderRadius:
                                              BorderRadius.circular(28)),
                                      padding: const EdgeInsets.all(1.0),
                                      child: IconButton(
                                          onPressed: () {
                                            guardianCubit.refreshLocation();
                                          },
                                          icon: Icon(
                                            Icons.refresh_rounded,
                                            size: 34,
                                            color: KDarkbluGrey,
                                          )),
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox.shrink(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: FilledButton(
                              onPressed: () {
                                setState(() {
                                  guardianCubit.locationMoniter();
                                });
                              },
                              style: FilledButton.styleFrom(
                                  minimumSize: const Size.fromHeight(60),
                                  backgroundColor:
                                      guardianCubit.isliveLocationMonitering
                                          ? kSuccessColor
                                          : kButtonPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(6.0))),
                              child: Text(
                                  guardianCubit.isliveLocationMonitering
                                      ? "Location Monitering"
                                      : "Moniter Live Location",
                                  style: kFilledButtonTextstyle)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )),
        bottomNavigationBar: BlocBuilder<SpeechToTextCubit, SpeechToTextState>(
          builder: (context, state) {
            if (state is Listning) {
              return li.Lottie.asset('assets/animations/assistant_circle.json',
                  width: 106, height: 106);
            } else {
              return const BottomNavBar(
                selectedIndex: 0,
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
