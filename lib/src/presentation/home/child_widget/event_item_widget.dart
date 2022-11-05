import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/extension.dart';
import 'package:todo_app/src/domain/model/event_model.dart';

class EventItemWidget extends StatelessWidget {
  final void Function(EventModel, bool) onChangeStatus;
  final void Function(EventModel) onDelete;
  final EventModel event;
  final RxBool isComplete = false.obs;
  EventItemWidget(
      {Key? key, required this.onChangeStatus, required this.event, required this.onDelete})
      : super(key: key) {
    isComplete.value = event.isDone ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(event.id.toString()),
      onDismissed: (direction) => onDelete(event),
      child: Card(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.content ?? '', style: context.textTheme.titleMedium),
                    Text(
                      event.date.format('dd/MM -  HH:mm') ?? '',
                      style: context.textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ),
            Obx(() => Checkbox(
                  value: isComplete.value,
                  onChanged: (value) {
                    if (value != null) {
                      isComplete.value = value;
                      onChangeStatus(event, value);
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
