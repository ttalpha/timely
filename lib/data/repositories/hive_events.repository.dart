import 'package:timely/data/datasources/local_datasource.dart';
import 'package:timely/data/dtos/add_event.dto.dart';
import 'package:timely/data/dtos/query_events.dto.dart';
import 'package:timely/data/dtos/update_event.dto.dart';
import 'package:timely/data/repositories/events.repository.dart';
import 'package:timely/domain/event.dart';
import 'package:uuid/uuid.dart';

class HiveEventsRepository implements EventsRepository {
  final LocalDataSource<Event> localDataSource;

  HiveEventsRepository(this.localDataSource);

  @override
  Future<Event> addEvent(AddEventDto addEventDto) async {
    const uuid = Uuid();
    final newEvent = Event(
      id: uuid.v4(),
      title: addEventDto.title,
      startTime: addEventDto.startTime,
      endTime: addEventDto.endTime,
      isCompleted: false,
      color: addEventDto.color,
    );
    await localDataSource.saveData(newEvent.id, newEvent);
    return newEvent;
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
  Future<Event> updateEvent(UpdateEventDto updateEventDto) async {
    final oldEvent = await localDataSource.findOne(updateEventDto.id);
    if (oldEvent == null) {
      throw Exception('Cannot find event with id: ${updateEventDto.id}');
    }
    final updatedEvent = Event(
      id: oldEvent.id,
      title: updateEventDto.title ?? oldEvent.title,
      startTime: updateEventDto.startTime ?? oldEvent.startTime,
      endTime: updateEventDto.endTime ?? oldEvent.endTime,
      isCompleted: updateEventDto.isCompleted ?? oldEvent.isCompleted,
      color: updateEventDto.color ?? oldEvent.color,
    );
    await localDataSource.saveData(oldEvent.id, updatedEvent);
    return updatedEvent;
  }
}
