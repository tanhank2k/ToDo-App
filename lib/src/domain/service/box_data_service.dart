import 'package:todo_app/core/enum_value.dart';
import 'package:todo_app/src/domain/model/event_model.dart';

abstract class BoxDataService {
  List<EventModel> getEvent(EventType eventType, String searchText);
  Future addOrUpdateEvent(EventModel event);
  void deleteEvent(int id);
}
