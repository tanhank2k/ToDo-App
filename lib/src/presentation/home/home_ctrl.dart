import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/enum_value.dart';
import 'package:todo_app/src/domain/model/event_model.dart';
import 'package:todo_app/src/domain/service/box_data_service.dart';

class HomeController extends GetxController {
  FocusNode focusNode = FocusNode();
  final TextEditingController searchTextController = TextEditingController();

  final RxList<EventModel> events = <EventModel>[].obs;
  final RxBool isGettingData = true.obs;
  final RxBool showClearTextField = false.obs;
  final RxBool showSearchField = false.obs;
  final Rx<EventType> eventTypeSelected = EventType.today.obs;
  @override
  void onInit() {
    super.onInit();
    searchTextController.addListener(() {
      if (searchTextController.text.isEmpty) {
        showClearTextField.value = false;
      } else {
        showClearTextField.value = true;
      }
    });
    _getData();
  }

  Future _getData() async {
    isGettingData.value = true;
    BoxDataService boxDataService = Get.find();
    List<EventModel> data =
        boxDataService.getEvent(eventTypeSelected.value, searchTextController.text);
    events.addAll(data);

    isGettingData.value = false;
  }

  void changeEventType(EventType eventType) {
    eventTypeSelected.value = eventType;
    events.clear();
    _getData();
  }

  void searchEvent() {
    events.clear();
    _getData();
  }

  void saveEventStatus(EventModel event, bool status) {
    event.isDone = status;
    BoxDataService boxDataService = Get.find();
    boxDataService.addOrUpdateEvent(event);
  }

  void deleteEvent(EventModel event) {
    events.remove(event);
    BoxDataService boxDataService = Get.find();
    boxDataService.deleteEvent(event.id);
  }
}
