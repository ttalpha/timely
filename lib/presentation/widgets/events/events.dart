import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx_triple/mobx_triple.dart';
import 'package:timely/data/dtos/query_events.dto.dart';
import 'package:timely/domain/event.dart';
import 'package:timely/main.dart';
import 'package:timely/presentation/stores/events_query_store.dart';
import 'package:timely/presentation/stores/events_store.dart';
import 'package:timely/presentation/widgets/events/event.dart';

class Events extends StatelessWidget {
  Events({super.key});
  final eventsStore = getIt<EventsStore>();
  final eventsQueryStore = getIt<EventsQueryStore>();

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<EventsQueryStore, QueryEventsDto>(
      store: eventsQueryStore,
      onError: (context, error) => Center(
        child: Text(
          'Something went wrong when loading events. Please try again!',
          style: TextStyle(color: Colors.redAccent[700]),
        ),
      ),
      onState: (context, queryState) {
        eventsStore.fetchEvents(queryState);
        final selectedDate = queryState.startTime ?? DateTime.now();
        return Stack(
          children: [
            SizedBox(
              height: 32,
              child: Center(
                child: Text(
                  DateFormat('d MMMM, y').format(selectedDate),
                  style: const TextStyle(
                    color: Colors.black45,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            ScopedBuilder<EventsStore, List<Event>>(
              store: eventsStore,
              onState: (context, state) => ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                itemCount: state.length,
                itemBuilder: (context, index) {
                  return EventItem(event: state[index]);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 12);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
