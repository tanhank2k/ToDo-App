import 'package:objectbox/objectbox.dart';

@Entity()
class EventModel {
  @Id()
  int id = 0;
  String? content;
  @Property(type: PropertyType.date)
  DateTime? date;
  bool? isDone;
  EventModel({this.content, this.date, this.isDone});
}
