import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:tryout/src/services/file_service.dart';

//import 'package:flutter_native_timezone/flutter_native_timezone.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

class NotificationService {
  final FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> init() async {
    tz.initializeTimeZones();
    //final locationName = await FlutterNativeTimezone.getLocalTimezone();
    //tz.setLocalLocation(tz.getLocation(locationName));

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {},
    );

    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);

    await localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse:(NotificationResponse notificationResponse) async {
        //App.navigateTo(Routes.notificationViewer, notificationResponse.payload);
        
      },
    );
  }

  Future show(
          {int id = 1000,
          String? title,
          String? body,
          String? payload
  }) async =>
      localNotificationsPlugin.show(
        id, 
        title,
        body, 
        await _getDetails(),
        payload: payload
      );

  Future schedule({
    int id = 1000,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduleDate,
  }) async =>
      localNotificationsPlugin.zonedSchedule(
        id, 
        title, 
        body, 
        tz.TZDateTime.from(scheduleDate, tz.local),
        await _getDetails(),
        payload: payload,
        androidScheduleMode: AndroidScheduleMode.inexact,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
      );

  void cancel(int id) => localNotificationsPlugin.cancel(id);

  void cancelAll() => localNotificationsPlugin.cancelAll();

  Future _getDetails() async {
    final bigPicturePath = await FileService.downloadFile(
      'https://images.unsplash.com/photo-1606857521015-7f9fcf423740', 
      'bigPicture'
    );
    final largeIconPath = await FileService.downloadFile(
      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80', 
      'largeIcon'
    );    
    final styleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(largeIconPath)
    );
    return NotificationDetails(
        android: AndroidNotificationDetails(
          'HC1001', 
          'Health Connected',
          channelDescription: 'Notification for Health Connected',
          importance: Importance.max,
          styleInformation: styleInformation,
          icon: '@mipmap/ic_launcher'),
        iOS: const DarwinNotificationDetails());
  }
}
