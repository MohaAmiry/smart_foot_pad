import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial_ble/flutter_bluetooth_serial_ble.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_foot_pad/Features/DiscoverDevices/Controllers/DevicesController.dart';
import 'package:smart_foot_pad/Features/Sensors/Data/SensorsRepository.dart';
import 'package:smart_foot_pad/Features/Sensors/Domain/CurrentSensorReadModel.dart';
import 'package:smart_foot_pad/Features/Sensors/Domain/SensorsDataModel.dart';
import 'package:smart_foot_pad/Features/Sensors/Presentation/Controllers/DaysProvider.dart';
import 'package:smart_foot_pad/Utils/Notifications/LocalNotification.dart';

import '../../Domain/DeviceModel.dart';
import '../../Domain/ReportModel.dart';

part 'DeviceDataController.g.dart';

@riverpod
class DataController extends _$DataController {
  @override
  FutureOr<SensorReadLiveModel?> build() async {
    return null;
  }

  void addText(String val) {
    var sensorData = SensorReadLiveModel.fromString(val);
    sensorData = SensorReadLiveModel(
      oxygen: sensorData.oxygen,
      humidity: sensorData.humidity,
      temperature: sensorData.temperature - Random().nextInt((3).toInt()),
    );
    state = AsyncData(sensorData);
    ref
        .read(sensorsRepositoryProvider)
        .requireValue
        .addSensorRead(SensorsDataModel.fromString(val));
    bool tempCritical = isCriticalVal(
      ReadType.temperature,
      sensorData.temperature,
    );
    bool humidityCritical = isCriticalVal(
      ReadType.humidity,
      sensorData.humidity,
    );
    bool oxygenCritical = isCriticalVal(ReadType.oxygen, sensorData.oxygen);
    print(sensorData.toString());
    print(
      "Temp: $tempCritical,Humidity: $humidityCritical,Oxy: $oxygenCritical",
    );
    String errorMsg = "";
    if (tempCritical) {
      errorMsg += "Feet Temperature Is Unbalanced!\n";
    }
    if (humidityCritical) {
      errorMsg += "Feet Humidity Is Increasing So Much!\n";
    }
    if (oxygenCritical) {
      errorMsg += "The Oxygenation Saturation is Too Low!\n";
    }
    if (errorMsg.isNotEmpty) {
      ref
          .read(localNotificationProvider)
          .requireValue
          .showNotificationAlarm(errorMsg);
    }
  }
}

@riverpod
class DeviceModelController extends _$DeviceModelController {
  StreamSubscription? dataSub;

  @override
  FutureOr<DeviceModel> build() async {
    var conn = await ref.watch(
      connectionProvider.selectAsync((value) => value),
    );
    var device = await ref.watch(
      currentDeviceControllerProvider.selectAsync((value) => value),
    );

    if (conn == null) {
      dataSub?.cancel();
    } else {
      dataSub = conn.input!.listen((event) {
        ref
            .read(dataControllerProvider.notifier)
            .addText(convertToString(event));
      })..onDone(() {
        dataSub?.cancel();
      });
    }
    return DeviceModel(connection: conn, device: device);
  }
}

@riverpod
Future<BluetoothConnection?> connection(ConnectionRef ref) async {
  var device = await ref.watch(
    currentDeviceControllerProvider.selectAsync((value) => value),
  );
  print(device);
  if (device == null) return null;
  return await BluetoothConnection.toAddress(device.address);
}

String convertToString(Uint8List data) {
  String _messageBuffer = "";
  String message = "";
  int backspacesCounter = 0;
  data.forEach((byte) {
    if (byte == 8 || byte == 127) {
      backspacesCounter++;
    }
  });
  Uint8List buffer = Uint8List(data.length - backspacesCounter);
  int bufferIndex = buffer.length;

  // Apply backspace control character
  backspacesCounter = 0;
  for (int i = data.length - 1; i >= 0; i--) {
    if (data[i] == 8 || data[i] == 127) {
      backspacesCounter++;
    } else {
      if (backspacesCounter > 0) {
        backspacesCounter--;
      } else {
        buffer[--bufferIndex] = data[i];
      }
    }
  }

  String dataString = String.fromCharCodes(buffer);
  int index = buffer.indexOf(13);
  if (~index != 0) {
    message =
        backspacesCounter > 0
            ? _messageBuffer.substring(
              0,
              _messageBuffer.length - backspacesCounter,
            )
            : _messageBuffer + dataString.substring(0, index);

    _messageBuffer = dataString.substring(index);
  } else {
    _messageBuffer =
        (backspacesCounter > 0
            ? _messageBuffer.substring(
              0,
              _messageBuffer.length - backspacesCounter,
            )
            : _messageBuffer + dataString);
  }
  return message;
}
