import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visionmate/core/util/functions/text_to_speech_helper.dart';
part 'connect_cane_state.dart';

class ConnectCaneCubit extends Cubit<ConnectCaneState> {
  ConnectCaneCubit() : super(ConnectCaneInitial());

  FlutterBlue ble = FlutterBlue.instance;
  Stream<List<ScanResult>> get scanResult => ble.scanResults;
  bool isCaneConnected = false;

  Future scanDevices() async {
    if (await Permission.bluetoothScan.request().isGranted) {
      if (await Permission.bluetoothConnect.request().isGranted) {
        textToSpeech("Scanning Devices");
        ble.startScan(timeout: const Duration(seconds: 10));

        ble.stopScan();
      }
    }
  }

  Future<bool> connectByIndex(int deviceId) async {
    try {
      emit(CaneConnecting());
      List<ScanResult> deviceList =
          await scanResult.firstWhere((element) => true);
      var selectedDevice = deviceList.elementAt(deviceId).device;
      var connectedDevices = await ble.connectedDevices;
      for (var connectedDevice in connectedDevices) {
        //avoiding the attempt to reconnect with already connected device
        if (connectedDevice.id.id == selectedDevice.id.id) {
          emit(CaneConnectionError());
          return false;
        }
      }
      if (selectedDevice.name != "HMSoft") {
        emit(CaneConnectionError());
        return false;
      } else {
        selectedDevice.connect();
        textToSpeech("Cane Connected");
        !isCaneConnected;
      }
      emit(CaneConnected());
      return true;
    } catch (ex) {
      emit(CaneConnectionError());
      return false;
    }
  }
}
