import 'package:taskpal/data/dtos/query_events.dto.dart';
import 'package:taskpal/domain/event.dart';

abstract class EventsRepository {
  EventsRepository();

  Future<List<Event>> queryEvents(QueryEventsDto queryEventsDto);

  Future<void> addEvent(Event event);

  Future<Event?> getEventDetails(String id);

  Future<void> updateEvent(Event event);

  Future<void> deleteEvent(String id);
}
