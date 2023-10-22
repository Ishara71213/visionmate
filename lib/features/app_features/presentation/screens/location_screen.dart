// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  void dispose() {
    _locationSearchController.dispose();
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
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: [
                        SizedBox(
                          height: size.height - 80,
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
                                  print(state.curruntLocation.latitude
                                          .toString() +
                                      "   " +
                                      state.curruntLocation.longitude
                                          .toString());
                                  // The GoogleMapController is ready, you can call methods on it here.
                                  locationCubit.updateMapCameraView(
                                      state.curruntLocation.latitude.toString(),
                                      state.curruntLocation.longitude
                                          .toString(),
                                      controller);
                                });
                              } else {
                                currentLocation =
                                    const LatLng(6.818623, 79.919339);
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
                                    markerId: const MarkerId('startLocation'),
                                    position: currentLocation,
                                    infoWindow: const InfoWindow(
                                        title: 'Start Location'),
                                  ),
                                  Marker(
                                    markerId: const MarkerId('currentLocation'),
                                    position: currentLocation,
                                    infoWindow: const InfoWindow(
                                        title: 'Current Location'),
                                  ),
                                  Marker(
                                    markerId:
                                        const MarkerId('destinationLocation'),
                                    // position: LatLng(6.9222633, 79.9233583),
                                    position: destinationLocation,
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
