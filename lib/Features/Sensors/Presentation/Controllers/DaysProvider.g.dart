// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DaysProvider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getDaysHash() => r'3c93c1ecc4952491d665e5319aefe0d17ca3accd';

/// See also [getDays].
@ProviderFor(getDays)
final getDaysProvider = AutoDisposeFutureProvider<List<DateTime>>.internal(
  getDays,
  name: r'getDaysProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getDaysHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetDaysRef = AutoDisposeFutureProviderRef<List<DateTime>>;
String _$sensorReadsByDayHash() => r'aafaff2bb6bedba80d58940f45e149f82b6e361d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [sensorReadsByDay].
@ProviderFor(sensorReadsByDay)
const sensorReadsByDayProvider = SensorReadsByDayFamily();

/// See also [sensorReadsByDay].
class SensorReadsByDayFamily extends Family<AsyncValue<ReportModel>> {
  /// See also [sensorReadsByDay].
  const SensorReadsByDayFamily();

  /// See also [sensorReadsByDay].
  SensorReadsByDayProvider call(
    DateTime dateTime,
  ) {
    return SensorReadsByDayProvider(
      dateTime,
    );
  }

  @override
  SensorReadsByDayProvider getProviderOverride(
    covariant SensorReadsByDayProvider provider,
  ) {
    return call(
      provider.dateTime,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'sensorReadsByDayProvider';
}

/// See also [sensorReadsByDay].
class SensorReadsByDayProvider extends AutoDisposeFutureProvider<ReportModel> {
  /// See also [sensorReadsByDay].
  SensorReadsByDayProvider(
    DateTime dateTime,
  ) : this._internal(
          (ref) => sensorReadsByDay(
            ref as SensorReadsByDayRef,
            dateTime,
          ),
          from: sensorReadsByDayProvider,
          name: r'sensorReadsByDayProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sensorReadsByDayHash,
          dependencies: SensorReadsByDayFamily._dependencies,
          allTransitiveDependencies:
              SensorReadsByDayFamily._allTransitiveDependencies,
          dateTime: dateTime,
        );

  SensorReadsByDayProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dateTime,
  }) : super.internal();

  final DateTime dateTime;

  @override
  Override overrideWith(
    FutureOr<ReportModel> Function(SensorReadsByDayRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SensorReadsByDayProvider._internal(
        (ref) => create(ref as SensorReadsByDayRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dateTime: dateTime,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ReportModel> createElement() {
    return _SensorReadsByDayProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SensorReadsByDayProvider && other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dateTime.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SensorReadsByDayRef on AutoDisposeFutureProviderRef<ReportModel> {
  /// The parameter `dateTime` of this provider.
  DateTime get dateTime;
}

class _SensorReadsByDayProviderElement
    extends AutoDisposeFutureProviderElement<ReportModel>
    with SensorReadsByDayRef {
  _SensorReadsByDayProviderElement(super.provider);

  @override
  DateTime get dateTime => (origin as SensorReadsByDayProvider).dateTime;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
