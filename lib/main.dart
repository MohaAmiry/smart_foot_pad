import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_foot_pad/Features/Sensors/Data/SensorsRepository.dart';
import 'package:smart_foot_pad/Features/pedometerFeature/Data/StepsRepository.dart';
import 'package:smart_foot_pad/Features/pedometerFeature/Presentation/Controllers/StepsController.dart';
import 'package:smart_foot_pad/Utils/Notifications/LocalNotification.dart';
import 'package:smart_foot_pad/Utils/state_logger.dart';

import 'Router/Router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await [Permission.activityRecognition].request();

  runApp(const ProviderScope(observers: [StateLogger()], child: WarmUp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6488E4)),
      ),
      title: 'Smart Foot Pad',
      routerConfig: ref
          .watch(routerProvider)
          .config(navigatorObservers: () => [MyObserver()]),
    );
  }
}

class WarmUp extends ConsumerStatefulWidget {
  const WarmUp({super.key});

  @override
  ConsumerState createState() => _WarmUpState();
}

class _WarmUpState extends ConsumerState<WarmUp> {
  bool warmedUp = false;

  @override
  Widget build(BuildContext context) {
    if (warmedUp) {
      ref.watch(stepsStreamProvider);
      runApp(const ProviderScope(observers: [StateLogger()], child: MyApp()));
    }
    var listenables = <ProviderListenable<AsyncValue<Object?>>>[
      sensorsRepositoryProvider,
      localNotificationProvider,
      stepsRepositoryProvider,
    ];
    var states = listenables.map(ref.watch).toList();

    if (states.every((element) => element is AsyncData)) {
      Future(() => setState(() => warmedUp = true));
    }
    return FittedBox(child: Container());
  }
}
