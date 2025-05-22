// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DeviceDataController.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$connectionHash() => r'd1891ddd6f1e760bcbbf132e7069dabcc8ee5b47';

/// See also [connection].
@ProviderFor(connection)
final connectionProvider =
    AutoDisposeFutureProvider<BluetoothConnection?>.internal(
  connection,
  name: r'connectionProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$connectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConnectionRef = AutoDisposeFutureProviderRef<BluetoothConnection?>;
String _$dataControllerHash() => r'4c12de30704413b8c893dc152edab5303663d0c2';

/// See also [DataController].
@ProviderFor(DataController)
final dataControllerProvider = AutoDisposeAsyncNotifierProvider<DataController,
    SensorReadLiveModel?>.internal(
  DataController.new,
  name: r'dataControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dataControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DataController = AutoDisposeAsyncNotifier<SensorReadLiveModel?>;
String _$deviceModelControllerHash() =>
    r'1b0ec221144aef02726818a714b66a8aa5e57712';

/// See also [DeviceModelController].
@ProviderFor(DeviceModelController)
final deviceModelControllerProvider = AutoDisposeAsyncNotifierProvider<
    DeviceModelController, DeviceModel>.internal(
  DeviceModelController.new,
  name: r'deviceModelControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deviceModelControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeviceModelController = AutoDisposeAsyncNotifier<DeviceModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
