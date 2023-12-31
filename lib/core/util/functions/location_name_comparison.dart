import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/core/common/domain/entities/visually_impaired_user_entity.dart';
import 'package:visionmate/core/util/classes/visit_location.dart';
import 'package:visionmate/core/util/functions/text_to_speech_helper.dart';
import 'package:visionmate/features/app_features/presentation/bloc/location/cubit/location_cubit.dart';
import 'package:visionmate/features/app_features/presentation/bloc/viuser/cubit/viuser_cubit.dart';

VisitLocation compareLocationName(BuildContext context, String locationComand) {
  VisuallyImpairedUserEntity? viUserInfo =
      BlocProvider.of<ViuserCubit>(context).userInfo;
  LocationCubit locationCubit = BlocProvider.of<LocationCubit>(context);

  List<VisitLocation>? visitLocationList = viUserInfo?.visitLocation;
  VisitLocation macthedLocation =
      const VisitLocation(locationName: "not found");

  if (visitLocationList != null && visitLocationList.isNotEmpty) {
    for (var location in visitLocationList) {
      if (location.locationName?.toLowerCase() ==
              locationComand.toLowerCase() ||
          location.locationPurpose?.toLowerCase() ==
              locationComand.toLowerCase()) {
        macthedLocation = VisitLocation(
            locationName: location.locationName,
            locationPurpose: location.locationPurpose,
            locationCordinates: location.locationCordinates);

        locationCubit.setDestinationAndStartLocation(macthedLocation);
        textToSpeech("Directions to ${location.locationName}");
      }
    }
  } else {
    macthedLocation = const VisitLocation(locationName: "not found");
    textToSpeech("Directions Not Found");
    locationCubit.setDestinationAndStartLocation(macthedLocation);
  }
  return macthedLocation;
}
