part of 'viuser_cubit.dart';

sealed class ViuserState extends Equatable {
  const ViuserState();

  @override
  List<Object> get props => [];
}

final class ViuserInitial extends ViuserState {
  @override
  List<Object> get props => [];
}

final class ViuserDataLoading extends ViuserState {
  const ViuserDataLoading();

  @override
  List<Object> get props => [];
}

final class ViuserDataLoadingComplete extends ViuserState {
  const ViuserDataLoadingComplete();

  @override
  List<Object> get props => [];
}

final class ViuserDataLoadingError extends ViuserState {
  const ViuserDataLoadingError();

  @override
  List<Object> get props => [];
}
