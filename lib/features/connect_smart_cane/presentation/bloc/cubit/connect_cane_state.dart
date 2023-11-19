part of 'connect_cane_cubit.dart';

sealed class ConnectCaneState extends Equatable {
  const ConnectCaneState();

  @override
  List<Object> get props => [];
}

final class ConnectCaneInitial extends ConnectCaneState {}

final class CaneConnecting extends ConnectCaneState {}

final class CaneConnected extends ConnectCaneState {}

final class CaneDisconnected extends ConnectCaneState {}

final class CaneDisconnecting extends ConnectCaneState {}

final class CaneConnectionError extends ConnectCaneState {}

final class SearchConnections extends ConnectCaneState {}

final class NewConnections extends ConnectCaneState {}
