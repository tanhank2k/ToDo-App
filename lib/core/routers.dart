import 'package:get/get.dart';
import 'package:todo_app/src/presentation/add_event/add_event_ctrl.dart';
import 'package:todo_app/src/presentation/add_event/add_event_view.dart';
import 'package:todo_app/src/presentation/home/home_ctrl.dart';
import 'package:todo_app/src/presentation/home/home_view.dart';

List<GetPage> routers = [
  GetPage(
    name: HomeView.routeName,
    page: () => const HomeView(),
    binding: BindingsBuilder(() {
      Get.lazyPut<HomeController>(() => HomeController());
    }),
  ),
  GetPage(
    name: AddEventView.routeName,
    page: () => const AddEventView(),
    binding: BindingsBuilder(() {
      Get.lazyPut<AddEventController>(() => AddEventController());
    }),
  )
];
