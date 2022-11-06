import 'package:get/get.dart';
import 'package:todo_app/src/domain/service/box_data_service.dart';
import 'package:todo_app/src/domain/service/local_notice_service.dart';
import 'package:todo_app/src/infrastructure/repository/box_data_repository.dart';
import 'package:todo_app/src/infrastructure/repository/local_notice_repository.dart';

class GlobalBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut<LocalNoticeService>(() => LocalNoticeRepository());
    Get.lazyPut<BoxDataService>(() => BoxDataRepository());
  }
}
