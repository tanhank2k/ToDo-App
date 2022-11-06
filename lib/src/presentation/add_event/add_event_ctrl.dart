import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/utils.dart';
import 'package:todo_app/src/domain/model/event_model.dart';
import 'package:todo_app/src/domain/service/box_data_service.dart';
import 'package:todo_app/src/domain/service/local_notice_service.dart';

class AddEventController extends GetxController {
  final TextEditingController contentTextController = TextEditingController();
  final Rx<DateTime> daySelected = DateTime.now().add(const Duration(days: 1)).obs;
  final RxBool showClearTextField = false.obs;
  Future addEvent() async {
    Util.showLoading();
    BoxDataService boxDataService = Get.find();
    LocalNoticeService localNoticeService = Get.find();

    EventModel data = EventModel(
      isDone: false,
      date: daySelected.value,
      content: contentTextController.text,
    );

    /// save to local db
    await boxDataService.addOrUpdateEvent(data);

    /// create schedule notification
    await localNoticeService.setNotification(data);
    Util.hideLoading();
  }
}
