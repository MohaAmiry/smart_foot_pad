import 'package:flutter_bluetooth_serial_ble/flutter_bluetooth_serial_ble.dart';

class DeviceModel {
  BluetoothDevice? device;
  BluetoothConnection? connection;

  bool isConnecting;
  bool isDisconnecting;

  DeviceModel(
      {this.device,
      this.connection,
      this.isConnecting = false,
      this.isDisconnecting = false});

  bool get isConnected => connection?.isConnected ?? false;

  @override
  String toString() {
    return 'DeviceModel{device: $device, connection: $connection, isConnecting: $isConnecting, isDisconnecting: $isDisconnecting}';
  }
}
