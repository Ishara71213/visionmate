part of 'guardian_cubit.dart';

sealed class GuardianState extends Equatable {
  const GuardianState();

  @override
  List<Object> get props => [];
}

final class GuardianInitial extends GuardianState {
  @override
  List<Object> get props => [];
}

final class GuardianDataLoading extends GuardianState {
  const GuardianDataLoading();

  @override
  List<Object> get props => [];
}

final class GuardianDataLoadingComplete extends GuardianState {
  const GuardianDataLoadingComplete();

  @override
  List<Object> get props => [];
}

final class GuardianDataLoadingError extends GuardianState {
  const GuardianDataLoadingError();

  @override
  List<Object> get props => [];
}

class GuardianLocationDataGathering extends GuardianState {
  final LatLng curruntLocation;
  const GuardianLocationDataGathering(
      {this.curruntLocation = const LatLng(10, 10.0)});
  @override
  List<Object> get props => [curruntLocation];
}

class LiveLocationDataMonitoring extends GuardianState {
  final LatLng curruntLocation;
  final LatLng wardLocation;
  const LiveLocationDataMonitoring(
      {this.curruntLocation = const LatLng(10, 10.0),
      this.wardLocation = const LatLng(10, 10.0)});
  @override
  List<Object> get props => [curruntLocation, wardLocation];
}
