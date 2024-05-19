import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final notifications = FlutterLocalNotificationsPlugin();

initNotification() async {
  var androidSetting = AndroidInitializationSettings('favicon');

  var iosSetting = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  var initalizationSettings = InitializationSettings(
    android: androidSetting,
    iOS: iosSetting,
  );
  await notifications.initialize(
    initalizationSettings,
  );
}

showNotificationTimeSetting(String Title, String Content, int AlarmTime) async {
  tz.initializeTimeZones();

  var androidDetails = const AndroidNotificationDetails(
      'mud_safety',
      'this warning to get away mud',
      priority: Priority.high,
      importance: Importance.max,
  );
  var iosDetails = const DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  notifications.zonedSchedule(
    2,
    Title,
    Content,
    tz.TZDateTime.now(tz.local).add(Duration(seconds: AlarmTime)),
    NotificationDetails(android: androidDetails, iOS: iosDetails),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
  );
}

cancelNotification() async {
  await notifications.cancelAll();
}