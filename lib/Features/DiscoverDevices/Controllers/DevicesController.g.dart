// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DevicesController.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deviceStreamHash() => r'36877803348ae25d6eb31f51f7c0f9a33e54cd5e';

/// See also [deviceStream].
@ProviderFor(deviceStream)
final deviceStreamProvider =
    AutoDisposeStreamProvider<BluetoothDevice?>.internal(
  deviceStream,
  name: r'deviceStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$deviceStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DeviceStreamRef = AutoDisposeStreamProviderRef<BluetoothDevice?>;
String _$currentDeviceControllerHash() =>
    r'45f70695b30267041f3e8124bf970e72cdb9b0a3';

/// See also [CurrentDeviceController].
@ProviderFor(CurrentDeviceController)
final currentDeviceControllerProvider =
    AsyncNotifierProvider<CurrentDeviceController, BluetoothDevice?>.internal(
  CurrentDeviceController.new,
  name: r'currentDeviceControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentDeviceControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentDeviceController = AsyncNotifier<BluetoothDevice?>;
String _$deviceDiscoveryControllerHash() =>
    r'fc017c3f74111985ca3e4d29f0a063de6d2dc61f';

/// See also [DeviceDiscoveryController].
@ProviderFor(DeviceDiscoveryController)
final deviceDiscoveryControllerProvider = AutoDisposeAsyncNotifierProvider<
    DeviceDiscoveryController, BluetoothDevice?>.internal(
  DeviceDiscoveryController.new,
  name: r'deviceDiscoveryControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deviceDiscoveryControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeviceDiscoveryController
    = AutoDisposeAsyncNotifier<BluetoothDevice?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
