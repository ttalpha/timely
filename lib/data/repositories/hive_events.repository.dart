import 'package:taskpal/data/datasources/local_datasource.dart';
import 'package:taskpal/data/dtos/query_events.dto.dart';
import 'package:taskpal/data/repositories/events.repository.dart';
import 'package:taskpal/domain/event.dart';

class HiveEventsRepository implements EventsRepository {
  final LocalDataSource<Event> localDataSource;

  HiveEventsRepository(this.localDataSource);

  @override
  Future<void> addEvent(Event event) async {
    await localDataSource.saveData(event.id, event);
  }

  @override
  Future<void> deleteEvent(String id) async {
    await localDataSource.removeData(id);
  }

  @override
  Future<Event?> getEventDetails(String id) async {
    return localDataSource.findOne(id);
  }

  @override
  Future<List<Event>> queryEvents(QueryEventsDto queryEventsDto) async {
    final events = await localDataSource.findMany();
    Iterable<Event> toFilterEvents = List.of(events);

    if (queryEventsDto.keyword.isNotEmpty) {
      toFilterEvents = toFilterEvents.where((event) {
        final titleLowercase = event.title.toLowerCase();
        final keywordLowercase = queryEventsDto.keyword.toLowerCase();
        return titleLowercase.contains(keywordLowercase);
      });
    }

    if (queryEventsDto.startTime != null) {
      toFilterEvents = toFilterEvents.where((event) {
        return event.startTime.isAfter(queryEventsDto.startTime!);
      });
    }

    if (queryEventsDto.endTime != null) {
      toFilterEvents = toFilterEvents.where((event) {
        return event.endTime.isBefore(queryEventsDto.endTime!);
      });
    }

    if (queryEventsDto.isCompleted != null) {
      toFilterEvents = toFilterEvents.where((event) {
        return event.isCompleted == queryEventsDto.isCompleted;
      });
    }

    if (queryEventsDto.colors.isNotEmpty) {
      toFilterEvents = toFilterEvents.where((event) {
        return queryEventsDto.colors.contains(event.color);
      });
    }

    toFilterEvents = toFilterEvents.toList();
    (toFilterEvents as List<Event>).sort((a, b) => a.startTime.compareTo(b.startTime));
    return toFilterEvents;
  }

  @override
  Future<void> updateEvent(Event event) async {
    await localDataSource.saveData(event.id, event);
  }
}
