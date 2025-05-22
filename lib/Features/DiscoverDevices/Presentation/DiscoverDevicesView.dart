import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_ble/flutter_bluetooth_serial_ble.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_foot_pad/Features/DiscoverDevices/Controllers/DevicesController.dart';
import 'package:smart_foot_pad/Features/Splash/ErrorView.dart';
import 'package:smart_foot_pad/Features/Splash/LoadingView.dart';

import '../../Splash/EmptyDataView.dart';

@RoutePage()
class DiscoverDevicesView extends ConsumerWidget {
  const DiscoverDevicesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Connect To Insole"),
        leading: IconButton(
          onPressed: () => ref.invalidate(deviceStreamProvider),
          icon: const Icon(Icons.refresh),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ref
            .watch(deviceDiscoveryControllerProvider)
            .when(
              data:
                  (data) =>
                      data == null
                          ? const EmptyDataView(
                            message: "No Available Device Found",
                          )
                          : Center(child: deviceInfo(data, ref)),
              error: (error, stackTrace) => ErrorView(error: error),
              loading: () => const LoadingView(),
            ),
      ),
    );
  }

  Widget deviceInfo(BluetoothDevice device, WidgetRef ref) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(device.name ?? "Unnamed Device"),
      ElevatedButton(
        onPressed:
            () =>
                device.isBonded
                    ? ref
                        .read(deviceDiscoveryControllerProvider.notifier)
                        .changeDeviceState(device.address, false)
                    : ref
                        .read(deviceDiscoveryControllerProvider.notifier)
                        .changeDeviceState(device.address, true),
        child: Text(device.isBonded ? "Unbond Device" : "Bond Device"),
      ),
    ],
  );
}
