import 'package:get/get.dart';
import 'package:todo_app/core/enum_value.dart';
import 'package:todo_app/objectbox.g.dart';
import 'package:todo_app/src/domain/model/event_model.dart';
import 'package:todo_app/src/domain/service/box_data_service.dart';

class BoxDataRepository extends BoxDataService {
  final Store _store = Get.find();

  @override
  List<EventModel> getEvent(EventType eventType, String searchText) {
    Box<EventModel> eventBox = _store.box<EventModel>();
    Query<EventModel> query;
    switch (eventType) {
      case EventType.today:
        DateTime now = DateTime.now();
        query = (eventBox.query(EventModel_.content.contains(searchText) &
                EventModel_.date.between(
                    DateTime(now.year, now.month, now.day).millisecondsSinceEpoch,
                    DateTime(now.year, now.month, now.day)
                        .add(const Duration(days: 1))
                        .millisecondsSinceEpoch))
              ..order(EventModel_.date))
            .build();
        break;
      case EventType.upcoming:
        query = (eventBox.query(EventModel_.content.contains(searchText) &
                EventModel_.date.greaterThan(DateTime.now().millisecondsSinceEpoch) &
                EventModel_.isDone.equals(false))
              ..order(EventModel_.date))
            .build();
        break;
      case EventType.all:
        query = (eventBox.query(EventModel_.content.contains(searchText))..order(EventModel_.date))
            .build();
        break;
    }
    List<EventModel> result = query.find();
    query.close();
    return result;
  }

  @override
  Future addOrUpdateEvent(EventModel event) async {
    Box<EventModel> eventBox = _store.box<EventModel>();
    await eventBox.putAsync(event);
  }

  @override
  void deleteEvent(int id) {
    Box<EventModel> eventBox = _store.box<EventModel>();
    eventBox.remove(id);
  }
}
