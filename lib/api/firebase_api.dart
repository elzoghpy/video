import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static final AwesomeNotifications awesomeNotifications =
      AwesomeNotifications();
  static void initialize() {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          importance: NotificationImportance.Max,
          channelKey: "pushNotification",
          channelName: "High Importance Notification",
          channelDescription: "Notification channel for basic tests",
        )
      ],
      debug: true,
    );
  }

  static void showNotification(RemoteMessage message) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: message.messageId.hashCode,
        channelKey: 'pushNotification',
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
      ),
    );
  }
}
