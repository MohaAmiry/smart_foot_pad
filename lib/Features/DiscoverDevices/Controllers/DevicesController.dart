import 'dart:async';
import 'dart:developer';

import 'package:flutter_bluetooth_serial_ble/flutter_bluetooth_serial_ble.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_foot_pad/Utils/Constants.dart';

part 'DevicesController.g.dart';

@Riverpod(keepAlive: true)
class CurrentDeviceController extends _$CurrentDeviceController {
  @override
  FutureOr<BluetoothDevice?> build() async {
    var s = await FlutterBluetoothSerial.instance.getBondedDevices();
    var index = s.indexWhere((element) => element.name == deviceName);
    index < 0
        ? print("The Device is not bonded")
        : print(
          "The device is bonded at ${index}, with Val: ${s.elementAt(index).isBonded}",
        );
    print("insiideeeeeeeeeeeeeeeeee*************");
    return index < 0 ? null : s.elementAt(index);
  }

  void registerDevice(BluetoothDevice? device) {
    state = AsyncData(device);
  }
}

@riverpod
class DeviceDiscoveryController extends _$DeviceDiscoveryController {
  @override
  FutureOr<BluetoothDevice?> build() async {
    var device = await ref.watch(deviceStreamProvider.future);

    return device;
  }

  Future<void> changeDeviceState(String address, bool toBond) async {
    bool? result;
    if (toBond) {
      result = await FlutterBluetoothSerial.instance.bondDeviceAtAddress(
        address,
      );
    } else {
      result = await FlutterBluetoothSerial.instance
          .removeDeviceBondWithAddress(address);
    }
    if (result == null || !result) {
      log("error Occurred while changing device state");
      return;
    }
    state = AsyncData(
      BluetoothDevice(
        address: state.requireValue!.address,
        type: state.requireValue!.type,
        name: state.requireValue!.name,
        bondState:
            toBond && result
                ? BluetoothBondState.bonded
                : BluetoothBondState.none,
      ),
    );
    toBond && result
        ? ref
            .read(currentDeviceControllerProvider.notifier)
            .registerDevice(state.requireValue)
        : ref
            .read(currentDeviceControllerProvider.notifier)
            .registerDevice(null);
  }
}

@riverpod
Stream<BluetoothDevice?> deviceStream(DeviceStreamRef ref) async* {
  var transformer = StreamTransformer<
    BluetoothDiscoveryResult,
    BluetoothDiscoveryResult?
  >.fromHandlers(
    handleData: (data, sink) {
      sink.add(data);
      sink.close();
    },
    handleDone: (sink) {
      sink.add(null);
    },
  );
  var stream = FlutterBluetoothSerial.instance
      .startDiscovery()
      .where((event) {
        return event.device.name == deviceName;
      })
      .transform(transformer);

  await for (var e in stream) {
    yield e?.device;
  }
}
