import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskpal/presentation/widgets/events/weekdays.dart';

class EventsAppbar extends StatefulWidget {
  const EventsAppbar({super.key});

  @override
  State<EventsAppbar> createState() => _EventsAppbarState();
}

class _EventsAppbarState extends State<EventsAppbar> {
  void _changeView() {
    print("Change View");
  }

  void _search() {
    print("Search clicked");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First Row: Month & Year with actions
          Container(
            padding: const EdgeInsets.only(top: 8, bottom: 16, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat.yMMMM().format(DateTime.now()), // e.g., "October 2024"
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.calendar_view_day, color: Colors.black45),
                      onPressed: _changeView, // Action to change views
                    ),
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.black45),
                      onPressed: _search, // Action for search
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Weekdays()
        ],
      ),
    );
  }
}
