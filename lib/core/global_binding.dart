import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/objectbox.g.dart';

class GlobalBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: join(docsDir.path, "todo-box"));
    Get.lazyPut<Store>(() => store);
  }
}
