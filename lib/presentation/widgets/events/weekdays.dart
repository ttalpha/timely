import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx_triple/mobx_triple.dart';
import 'package:timely/data/dtos/query_events.dto.dart';
import 'package:timely/main.dart';
import 'package:timely/presentation/stores/events_query_store.dart';

class Weekdays extends StatefulWidget {
  const Weekdays({super.key});

  @override
  State<Weekdays> createState() => _WeekdaysState();
}

class _WeekdaysState extends State<Weekdays> {
  final _eventsQueryStore = getIt<EventsQueryStore>();

  final ScrollController _scrollController = ScrollController();
  List<DateTime> dates = [];
  double itemWidth = 48.0;
  int bufferSize = 15;

  @override
  void initState() {
    super.initState();

    initializeDates();
    selectToday();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(itemWidth * (dates.length ~/ 2) - 16);
    });
  }

  void selectToday() {
    DateTime today = DateTime.now();
    _eventsQueryStore.setDateQuery(today.day, today.month, today.year);
  }

  void initializeDates() {
    DateTime today = DateTime.now();
    for (int i = -bufferSize; i <= bufferSize; i++) {
      setState(() {
        dates.add(today.add(Duration(days: i)));
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels < itemWidth * 5) {
      loadMoreDatesBackward();
    }

    if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent - itemWidth * 5) {
      loadMoreDatesForward();
    }
  }

  void loadMoreDatesBackward() {
    setState(() {
      DateTime firstDate = dates.first;
      for (int i = 1; i <= bufferSize; i++) {
        dates.insert(0, firstDate.subtract(Duration(days: i)));
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.pixels + (itemWidth * bufferSize));
    });
  }

  void loadMoreDatesForward() {
    setState(() {
      DateTime lastDate = dates.last;
      for (int i = 1; i <= bufferSize; i++) {
        dates.add(lastDate.add(Duration(days: i)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<EventsQueryStore, QueryEventsDto>(
      store: _eventsQueryStore,
      onState: (context, state) {
        final selectedDate = state.startTime ?? DateTime.now();
        return SizedBox(
          height: 80,
          child: ListView.separated(
            controller: _scrollController,
            itemCount: dates.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final recentDay = dates[index];
              final today = DateTime.now();
              final isToday = recentDay.day == today.day && recentDay.month == today.month && recentDay.year == today.year;
              final isDateSelected =
                  recentDay.day == selectedDate.day && recentDay.month == selectedDate.month && recentDay.year == selectedDate.year;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.E().format(recentDay),
                    style: const TextStyle(fontSize: 14, color: Colors.black45),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _eventsQueryStore.setDateQuery(recentDay.day, recentDay.month, recentDay.year),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: isToday
                            ? Colors.blue[800]
                            : isDateSelected
                                ? Colors.blue[50]
                                : Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          recentDay.day.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: isToday
                                ? Colors.white
                                : isDateSelected
                                    ? Colors.blue[900]
                                    : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 16);
            },
          ),
        );
      },
    );
  }
}
