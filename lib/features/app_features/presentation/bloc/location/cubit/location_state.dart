part of 'location_cubit.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

final class LocationInitial extends LocationState {
  @override
  List<Object> get props => [];
}

class LocationDataGathering extends LocationState {
  final LatLng curruntLocation;
  const LocationDataGathering({this.curruntLocation = const LatLng(0, 0)});
  @override
  List<Object> get props => [curruntLocation];
}

class LocationStartDirections extends LocationState {
  final LatLng curruntLocation;
  final LatLng startLocation;
  final LatLng destinationLocation;
  final List<LatLng> polylineCordinates;
  const LocationStartDirections(
      {this.curruntLocation = const LatLng(0, 0),
      this.destinationLocation = const LatLng(0, 0),
      this.startLocation = const LatLng(0, 0),
      required this.polylineCordinates});
  @override
  List<Object> get props =>
      [curruntLocation, destinationLocation, startLocation, polylineCordinates];
}
