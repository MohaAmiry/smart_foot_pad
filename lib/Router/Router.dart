import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "View,Route")
class MyRoutes extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      initial: true,
      page: NavigationScaffoldRoute.page,
      children: [
        AutoRoute(path: '', page: SensorsRoute.page),
        AutoRoute(page: StepsRoute.page),
      ],
    ),
    AutoRoute(page: DiscoverDevicesRoute.page),
    AutoRoute(page: DailyReportRoute.page),
  ];
}

var routerProvider = Provider((ref) => MyRoutes());

class MyObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    log('New route pushed: ${route.settings.name}');
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    log('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    log('Tab route re-visited: ${route.name}');
  }
}
