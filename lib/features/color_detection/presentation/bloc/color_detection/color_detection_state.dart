part of 'color_detection_cubit.dart';

sealed class ColorDetectiontate extends Equatable {
  const ColorDetectiontate();

  @override
  List<Object> get props => [];
}

final class ColorDetectionInitial extends ColorDetectiontate {}

final class ColorDetectionOpenCamera extends ColorDetectiontate {}

final class ColorDetectionStartRecognition extends ColorDetectiontate {}

final class ColorDetectionSuccess extends ColorDetectiontate {}

final class ColorDetectionFailed extends ColorDetectiontate {}
