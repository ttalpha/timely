import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskpal/common/utils/event_colors.dart';
import 'package:taskpal/domain/event.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final eventColor = EventColorsUtils.mapColorToObject(event.color);

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 96),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: eventColor[50],
          border: Border.all(
            width: 1.0,
            color: WidgetStateColor.resolveWith(
              (states) {
                return Color(eventColor[700]!.value);
              },
            ),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${DateFormat.jm().format(event.startTime)} - ${DateFormat.jm().format(event.endTime)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black45,
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    event.title,
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      decoration: event.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
            Transform.scale(
              scale: 1.4,
              child: Checkbox(
                shape: const CircleBorder(),
                value: event.isCompleted,
                onChanged: (checked) {},
                activeColor: WidgetStateColor.resolveWith((states) {
                  return Color(eventColor[700]!.value);
                }),
                side: BorderSide(
                  color: WidgetStateColor.resolveWith(
                    (states) {
                      return Color(eventColor[700]!.value);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
