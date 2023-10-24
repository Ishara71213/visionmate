// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:lottie/lottie.dart' as Lt;
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:visionmate/core/constants/secret_api_keys.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:visionmate/core/widgets/input_widgets/input_widgets_library.dart';
import 'package:visionmate/features/app_features/presentation/bloc/location/cubit/location_cubit.dart';
import 'package:visionmate/features/app_features/presentation/bloc/viuser/cubit/viuser_cubit.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:visionmate/features/userInfoSetup/presentation/bloc/user_info/cubit/user_info_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final TextEditingController _locationSearchController =
      TextEditingController();
  late LocationCubit cubitref;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cubitref = BlocProvider.of<LocationCubit>(context);
  }

  @override
  void dispose() {
    _locationSearchController.dispose();
    _controller.future.then((GoogleMapController controller) {
      controller.dispose();
    });
    cubitref.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    LatLng currentLocation = const LatLng(6.8393012, 79.9003934);
    LatLng destinationLocation = const LatLng(6.8393012, 79.9003934);
    LocationCubit locationCubit = BlocProvider.of<LocationCubit>(context);

    return BlocListener<LocationCubit, LocationState>(
      listener: (context, state) async {},
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Directions"),
          backgroundColor: kPrimaryColor,
        ),
        body: GestureDetector(
          onLongPress: () {
            BlocProvider.of<SpeechToTextCubit>(context).listning(context);
          },
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      //height: size.height - 150,
                      child: BlocBuilder<LocationCubit, LocationState>(
                        builder: (context, state) {
                          if (state is LocationInitial) {
                            locationCubit
                                .checkIsLocationServiceEnabled(context);
                            locationCubit.determinePosition();
                          } else if (state is LocationDataGathering) {
                            currentLocation = state.curruntLocation;
                            _controller.future
                                .then((GoogleMapController controller) {
                              print(state.curruntLocation.latitude.toString() +
                                  "   " +
                                  state.curruntLocation.longitude.toString());
                              locationCubit.updateCurrentLocation(controller);
                              // The GoogleMapController is ready, you can call methods on it here.
                              locationCubit.updateMapCameraView(
                                  state.curruntLocation.latitude.toString(),
                                  state.curruntLocation.longitude.toString(),
                                  controller);
                            });
                          } else if (state is LocationStartDirections) {
                            currentLocation = state.curruntLocation;
                            _controller.future
                                .then((GoogleMapController controller) {
                              print(state.curruntLocation.latitude.toString() +
                                  "   " +
                                  state.curruntLocation.longitude.toString());
                              // The GoogleMapController is ready, you can call methods on it here.
                              locationCubit.updateCurrentLocation(controller);
                            });
                          } else {
                            currentLocation = const LatLng(6.818623, 79.919339);
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
                            polylines: {
                              Polyline(
                                  polylineId: const PolylineId("route"),
                                  points: locationCubit.polylineCordinates,
                                  color: kPrimaryColor,
                                  width: 6),
                            },
                            markers: {
                              Marker(
                                markerId: const MarkerId('currentLocation'),
                                position: state is LocationStartDirections
                                    ? state.curruntLocation
                                    : const LatLng(0, 0),
                                infoWindow:
                                    const InfoWindow(title: 'Current Location'),
                              ),
                              Marker(
                                markerId: const MarkerId('startLocation'),
                                position: state is LocationStartDirections
                                    ? state.startLocation
                                    : const LatLng(0, 0),
                                infoWindow:
                                    const InfoWindow(title: 'Start Location'),
                              ),
                              Marker(
                                markerId: const MarkerId('destinationLocation'),
                                // position: LatLng(6.9222633, 79.9233583),
                                position: state is LocationStartDirections
                                    ? state.destinationLocation
                                    : const LatLng(0, 0),
                                infoWindow: const InfoWindow(
                                    title: 'Destination Location'),
                              ),
                            },
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocBuilder<SpeechToTextCubit, SpeechToTextState>(
                      builder: (context, state) {
                        if (state is Listning) {
                          //return Text("listning");
                          return Lt.Lottie.asset(
                              'assets/animations/assistant_circle.json',
                              width: 106,
                              height: 106);
                        } else {
                          return const Padding(
                            padding: EdgeInsets.only(bottom: 16.0),
                            child: BottomNavBar(
                              selectedIndex: 3,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
