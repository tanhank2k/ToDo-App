import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:todo_app/core/enum_value.dart';
import 'package:todo_app/src/presentation/add_event/add_event_view.dart';
import 'package:todo_app/src/presentation/custom_widget/loading_widget.dart';
import 'package:todo_app/src/presentation/home/child_widget/event_item_widget.dart';
import 'package:todo_app/src/presentation/home/home_ctrl.dart';

class HomeView extends GetView<HomeController> {
  static const String routeName = '/HomeView';
  const HomeView({Key? key}) : super(key: key);

  void _onTapSearchBtn() {
    controller.showSearchField.toggle();
    FocusScope.of(Get.context!).requestFocus(controller.focusNode);
  }

  Future<void> _onTapAddBtn() async {
    var result = await Get.toNamed(AddEventView.routeName);
    if (result == true) {
      controller.searchEvent();
    }
  }

  void _onSearch() {
    controller.showSearchField.toggle();
    controller.searchEvent();
  }

  void _onClearFilter() => controller.searchTextController.text = '';

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo'),
          actions: [
            Obx(() => controller.showSearchField.value
                ? const SizedBox.shrink()
                : IconButton(onPressed: _onTapSearchBtn, icon: const Icon(Icons.search_rounded))),
            IconButton(onPressed: _onTapAddBtn, icon: const Icon(Icons.add_rounded)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(
                () => AnimatedCrossFade(
                  duration: const Duration(milliseconds: 500),
                  firstChild: const SizedBox.shrink(),
                  secondChild: DecoratedBox(
                    decoration: BoxDecoration(color: context.theme.colorScheme.background),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 45,
                              child: TextField(
                                focusNode: controller.focusNode,
                                controller: controller.searchTextController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(left: 14),
                                  hintText: 'Search event',
                                  border:
                                      OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
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
                          ),
                          const SizedBox(width: 4),
                          SizedBox(
                            height: 45,
                            child: ElevatedButton(
                              onPressed: _onSearch,
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: const Text('Search'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  crossFadeState: controller.showSearchField.value
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: context.theme.colorScheme.primary),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(() => DropdownButton<EventType>(
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        value: controller.eventTypeSelected.value,
                        menuMaxHeight: context.height * 0.5,
                        borderRadius: BorderRadius.circular(10),
                        items: EventType.values.map((e) {
                          return DropdownMenuItem<EventType>(
                            value: e,
                            child: SizedBox(
                              width: context.width * 0.7,
                              child: Text(
                                e.title,
                                style: context.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null && value != controller.eventTypeSelected.value) {
                            controller.changeEventType(value);
                          }
                        },
                      )),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Obx(
                  () => controller.isGettingData.value
                      ? const Center(child: LoadingWidget())
                      : Obx(
                          () => controller.events.isEmpty
                              ? Center(
                                  child: Text(
                                    'No Event\nAdd new to get started',
                                    style: context.textTheme.titleLarge,
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: controller.events.length,
                                  itemBuilder: (context, index) => EventItemWidget(
                                    onChangeStatus: controller.saveEventStatus,
                                    event: controller.events[index],
                                    onDelete: controller.deleteEvent,
                                  ),
                                ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
