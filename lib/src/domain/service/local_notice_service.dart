import 'package:todo_app/src/domain/model/event_model.dart';

abstract class LocalNoticeService {
  Future setNotification(EventModel event);
  Future cancelNotification(int eventId);
}
