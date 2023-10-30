part of 'object_detection_cubit.dart';

sealed class ObjectDetectionState extends Equatable {
  const ObjectDetectionState();

  @override
  List<Object> get props => [];
}

final class ObjectDetectionInitial extends ObjectDetectionState {}

final class ObjectDetectionModelLoading extends ObjectDetectionState {}

final class ObjectDetectionModelLoadingComplete extends ObjectDetectionState {}

final class ObjectDetectionModelLoadingFailed extends ObjectDetectionState {}

final class ObjectDetected extends ObjectDetectionState {}
