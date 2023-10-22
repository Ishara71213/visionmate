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
  final LatLng destinationLocation;
  const LocationDataGathering(
      {this.curruntLocation = const LatLng(10, 10.0),
      this.destinationLocation = const LatLng(10, 10)});
  @override
  List<Object> get props => [curruntLocation];
}
