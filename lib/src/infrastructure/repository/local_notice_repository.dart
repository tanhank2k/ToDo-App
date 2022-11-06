import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:todo_app/core/extension.dart';
import 'package:todo_app/src/domain/model/event_model.dart';
import 'package:todo_app/src/domain/service/local_notice_service.dart';

class LocalNoticeRepository extends LocalNoticeService {
  @override
  Future setNotification(EventModel event) async {
    bool isPermissionAllow = await AwesomeNotifications().isNotificationAllowed();
    if (!isPermissionAllow) {
      bool request = await AwesomeNotifications().requestPermissionToSendNotifications();
      if (!request) return;
    }
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: event.id,
        channelKey: 'todo_channel',
        title: 'An event is coming up',
        body: '${event.content} at ${event.date.format('HH:mm')}',
        wakeUpScreen: true,
        actionType: ActionType.Default,
        category: NotificationCategory.Event,
      ),
      schedule: NotificationCalendar.fromDate(
        date: event.date!.subtract(const Duration(minutes: 10)),
        repeats: true,
        preciseAlarm: true,
      ),
    );
  }

  @override
  Future cancelNotification(int eventId) async {
    await AwesomeNotifications().cancelSchedule(eventId);
  }
}
