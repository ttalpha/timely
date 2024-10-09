import 'package:timely/data/dtos/add_event.dto.dart';
import 'package:timely/data/dtos/query_events.dto.dart';
import 'package:timely/data/dtos/update_event.dto.dart';
import 'package:timely/domain/event.dart';

abstract class EventsRepository {
  EventsRepository();

  Future<List<Event>> queryEvents(QueryEventsDto queryEventsDto);

  Future<Event> addEvent(AddEventDto addEventDto);

  Future<Event?> getEventDetails(String id);

  Future<Event> updateEvent(UpdateEventDto updateEventDto);

  Future<void> deleteEvent(String id);
}
