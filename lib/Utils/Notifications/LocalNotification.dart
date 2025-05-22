import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'LocalNotification.g.dart';

const _channelID = "channelId";
const _channelName = "channelName";

@Riverpod(keepAlive: true)
Future<LocalNotificationRepository> localNotification(
    LocalNotificationRef ref) async {
  LocalNotificationRepository localNotificationRepository =
      LocalNotificationRepository();
  await localNotificationRepository.init();

  return localNotificationRepository;
}

class LocalNotificationRepository {
  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    plugin.initialize(
      initializationSettings,
    );

    await _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    final AndroidFlutterLocalNotificationsPlugin androidImplementation =
        plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!;

    var isEnabled = await androidImplementation.areNotificationsEnabled();
    if (isEnabled == false) {
      await androidImplementation.requestNotificationsPermission();
    }
  }

  Future<void> showNotificationAlarm(String body) async {
    var currentNotification = await plugin.getActiveNotifications();
    if (currentNotification.isNotEmpty) {
      return;
    }

    final List<String> lines = body.split("\n");
    final InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
        lines,
        htmlFormatLines: true,
        contentTitle: 'Unstable Reads Details',
        htmlFormatContentTitle: true);

    const int insistentFlag = 4;
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(_channelID, _channelName,
            importance: Importance.high,
            priority: Priority.high,
            additionalFlags: Int32List.fromList(<int>[insistentFlag]),
            playSound: true,
            sound: const RawResourceAndroidNotificationSound('alarm'),
            styleInformation: inboxStyleInformation);

    final NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await plugin.show(DateTime.now().millisecondsSinceEpoch ~/ 1000,
        'Warning, Unstable Reads!', body, notificationDetails);
  }
}
