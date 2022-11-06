import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/core/constant.dart';
import 'package:todo_app/core/global_binding.dart';
import 'package:todo_app/core/routers.dart';
import 'package:todo_app/src/presentation/home/home_view.dart';

import 'objectbox.g.dart';

Future<void> _initObjectBox() async {
  final docsDir = await getApplicationDocumentsDirectory();
  final store = await openStore(directory: join(docsDir.path, Constant.boxName));
  Get.lazyPut<Store>(() => store);
}

void _initAwesomeNotification() {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: Constant.channelGroupKey,
        channelKey: Constant.channelKey,
        channelName: Constant.channelName,
        channelDescription: Constant.channelDescription,
        defaultColor: Colors.blue,
        ledColor: Colors.white,
      )
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: Constant.channelGroupKey,
        channelGroupName: Constant.channelGroupName,
      )
    ],
    debug: true,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initObjectBox();
  _initAwesomeNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.green,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      getPages: routers,
      initialRoute: HomeView.routeName,
      initialBinding: GlobalBinding(),
    );
  }
}
