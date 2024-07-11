import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  static Future init() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
          channelGroupKey: "basic_chanell_group",
          channelKey: "basic_chanel",
          channelName: "park_n_wash",
          channelDescription: "parn_n_wash"),
      NotificationChannel(
          channelGroupKey: "scheduled_notifications_groupchanell_key",
          channelKey: "scheduled_notifications_chanellKey",
          channelName: "park_n_wash_scheduled_notifications",
          channelDescription: "scheduled_notifications_parn_n_wash"),
    ], channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: "basic_chanell_group",
          channelGroupName: "park_n_wash"),
      NotificationChannelGroup(
          channelGroupKey: "scheduled_notifications_groupchanell_key",
          channelGroupName: "scheduled_notifications_parn_n_wash"),
    ]);
  }

  static void sendNotification(String title, String body, int id) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: id,
            channelKey: "basic_chanel",
            title: title,
            body: body,
            notificationLayout: NotificationLayout.Default));
  }

  static Future<void> scheduleNotifications(
    int id,
    String body,
    String title,
    int interval
  ) async {
    String localTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();
  

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: 'scheduled_notifications_chanellKey',
          title: title,
          body: body,
          notificationLayout: NotificationLayout.Default,
        ),
        schedule: NotificationInterval(
            interval: interval, timeZone: localTimeZone, repeats: true));
  }
}
