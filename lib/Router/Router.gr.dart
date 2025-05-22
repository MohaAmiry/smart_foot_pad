// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:smart_foot_pad/Features/DiscoverDevices/Presentation/DiscoverDevicesView.dart'
    as _i2;
import 'package:smart_foot_pad/Features/pedometerFeature/Presentation/StepsView.dart'
    as _i5;
import 'package:smart_foot_pad/Features/Sensors/Presentation/CurrentSensorsView.dart'
    as _i4;
import 'package:smart_foot_pad/Features/Sensors/Presentation/DailyReportView.dart'
    as _i1;
import 'package:smart_foot_pad/Router/NavigationScaffold.dart' as _i3;

/// generated route for
/// [_i1.DailyReportView]
class DailyReportRoute extends _i6.PageRouteInfo<DailyReportRouteArgs> {
  DailyReportRoute({
    _i7.Key? key,
    required DateTime reportDate,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          DailyReportRoute.name,
          args: DailyReportRouteArgs(
            key: key,
            reportDate: reportDate,
          ),
          initialChildren: children,
        );

  static const String name = 'DailyReportRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DailyReportRouteArgs>();
      return _i1.DailyReportView(
        key: args.key,
        reportDate: args.reportDate,
      );
    },
  );
}

class DailyReportRouteArgs {
  const DailyReportRouteArgs({
    this.key,
    required this.reportDate,
  });

  final _i7.Key? key;

  final DateTime reportDate;

  @override
  String toString() {
    return 'DailyReportRouteArgs{key: $key, reportDate: $reportDate}';
  }
}

/// generated route for
/// [_i2.DiscoverDevicesView]
class DiscoverDevicesRoute extends _i6.PageRouteInfo<void> {
  const DiscoverDevicesRoute({List<_i6.PageRouteInfo>? children})
      : super(
          DiscoverDevicesRoute.name,
          initialChildren: children,
        );

  static const String name = 'DiscoverDevicesRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.DiscoverDevicesView();
    },
  );
}

/// generated route for
/// [_i3.NavigationScaffoldView]
class NavigationScaffoldRoute extends _i6.PageRouteInfo<void> {
  const NavigationScaffoldRoute({List<_i6.PageRouteInfo>? children})
      : super(
          NavigationScaffoldRoute.name,
          initialChildren: children,
        );

  static const String name = 'NavigationScaffoldRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.NavigationScaffoldView();
    },
  );
}

/// generated route for
/// [_i4.SensorsView]
class SensorsRoute extends _i6.PageRouteInfo<void> {
  const SensorsRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SensorsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SensorsRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.SensorsView();
    },
  );
}

/// generated route for
/// [_i5.StepsView]
class StepsRoute extends _i6.PageRouteInfo<void> {
  const StepsRoute({List<_i6.PageRouteInfo>? children})
      : super(
          StepsRoute.name,
          initialChildren: children,
        );

  static const String name = 'StepsRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.StepsView();
    },
  );
}
