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
  late BluetoothDevice selectedDevice;
  //Guid bleService = Guid("0000FFE0-0000-1000-8000-00805F9B34FB");
  Guid bleCharacteristicUUID = Guid("0000FFE1-0000-1000-8000-00805F9B34FB");

  Future<void> automatedWithVoiceMommand() async {
    await scanDevices().then((_) async => await connectByIName("HMSoft"));
  }

  Future scanDevices() async {
    if (await Permission.bluetoothScan.request().isGranted) {
      if (await Permission.bluetoothConnect.request().isGranted) {
        textToSpeech("Scanning Devices");
        await ble.startScan(timeout: const Duration(seconds: 10));

        await ble.stopScan();
      }
    }
  }

  Future<bool> connectByIndex(int deviceId) async {
    try {
      emit(CaneConnecting());
      List<ScanResult> deviceList =
          await scanResult.firstWhere((element) => true);
      selectedDevice = deviceList.elementAt(deviceId).device;
      var connectedDevices = await ble.connectedDevices;
      for (var connectedDevice in connectedDevices) {
        //avoiding the attempt to reconnect with already connected device
        if (connectedDevice.id.id == selectedDevice.id.id) {
          emit(CaneConnectionError());
          return false;
        }
      }
      if (selectedDevice.name != "HMSoft") {
        textToSpeech("Connection Error");
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

  Future<bool> connectByIName(String name) async {
    try {
      emit(CaneConnecting());
      List<ScanResult> deviceList =
          await scanResult.firstWhere((element) => true);
      BluetoothDevice? result = deviceList
          .where((element) => element.device.name == name)
          ?.first
          ?.device;

      if (result != null) {
        selectedDevice = result;
      }
      var connectedDevices = await ble.connectedDevices;
      for (var connectedDevice in connectedDevices) {
        //avoiding the attempt to reconnect with already connected device
        if (connectedDevice.id.id == selectedDevice.id.id) {
          emit(CaneConnectionError());
          return false;
        }
      }
      if (selectedDevice.name != name) {
        textToSpeech("Connection Error");
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

  Future<void> disconnectDevice() async {
    await selectedDevice.disconnect();
    textToSpeech("Cane Disconnected");
    !isCaneConnected;
    emit(CaneDisconnected());
  }

  Future<void> findDevice() async {
    // Discover services provided by the connected device
    List<int> dataToSend = [0x31];
    bool result =
        await sendDataToCharactersistic(bleCharacteristicUUID, dataToSend);
    if (result) {
      textToSpeech("Sound alarm initiated");
      emit(CaneSearching());
    }
  }

  Future<void> stopFindDevice() async {
    List<int> dataToSend = [0x30];
    bool result =
        await sendDataToCharactersistic(bleCharacteristicUUID, dataToSend);
    if (result) {
      textToSpeech("Sound alarm turned off");
      emit((CaneConnected()));
    }
  }

  Future<bool> sendDataToCharactersistic(
      Guid characteristicUUID, List<int> data) async {
    bool isSuccess = false;
    List<BluetoothService> services = await selectedDevice.discoverServices();
    services.forEach((service) async {
      // Discover characteristics within each service
      service.characteristics.forEach((characteristic) async {
        if (characteristic.uuid == characteristicUUID) {
          isSuccess = true;
          await characteristic.write(data);
        }
      });
    });
    return isSuccess;
  }
}
