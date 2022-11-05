import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:todo_app/core/extension.dart';
import 'package:todo_app/core/utils.dart';
import 'package:todo_app/src/presentation/add_event/add_event_ctrl.dart';

class AddEventView extends GetView<AddEventController> {
  static const String routeName = '/AddEventView';
  const AddEventView({Key? key}) : super(key: key);

  void _onClearFilter() => controller.contentTextController.text = '';
  Future<void> _selectDateTime() async {
    DateTime? dateSelected = await showDatePicker(
      context: Get.context!,
      initialDate: controller.daySelected.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (dateSelected == null) return;
    final timeSelected = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.fromDateTime(controller.daySelected.value),
    );
    if (timeSelected == null) return;
    controller.daySelected.value = DateTime(
      dateSelected.year,
      dateSelected.month,
      dateSelected.day,
      timeSelected.hour,
      timeSelected.minute,
    );
  }

  Future _onSave() async {
    await controller.addEvent();
    Get.back(result: true);
    Util.showSnackBar('Event added', backgroundColor: Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(title: const Text('Add event')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Text('Time:', style: context.textTheme.titleMedium),
              GestureDetector(
                onTap: _selectDateTime,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: context.theme.colorScheme.outline),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Obx(() => Text(
                          controller.daySelected.value.format('dd/MM/yyyy - HH:mm'),
                          style: context.textTheme.titleSmall,
                        )),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text('Content:', style: context.textTheme.titleMedium),
              SizedBox(
                height: 45,
                child: TextField(
                  controller: controller.contentTextController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 14),
                    hintText: 'Content',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                    suffixIcon: Obx(
                      () => controller.showClearTextField.value
                          ? GestureDetector(
                              onTap: _onClearFilter,
                              child: const Icon(Icons.close_rounded),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(onPressed: _onSave, child: const Text('SAVE'))
            ],
          ),
        ),
      ),
    );
  }
}
