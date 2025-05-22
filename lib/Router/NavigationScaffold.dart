import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_foot_pad/Router/Router.gr.dart';

@RoutePage()
class NavigationScaffoldView extends ConsumerWidget {
  const NavigationScaffoldView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsScaffold(
      routes: const [SensorsRoute(), StepsRoute()],
      bottomNavigationBuilder:
          (context, tabsRouter) => BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              tabsRouter.setActiveIndex(value);
            },
            items: const [
              BottomNavigationBarItem(
                icon: SizedBox(
                  height: 20,
                  width: 20,
                  child: Icon(Icons.sensors),
                ),
                label: "Sensors",
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  height: 20,
                  width: 20,
                  child: Icon(Icons.directions_walk),
                ),
                label: "Steps",
              ),
            ],
          ),
    );
  }
}
