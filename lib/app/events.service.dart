import 'package:taskpal/data/dtos/add_event.dto.dart';
import 'package:taskpal/data/dtos/query_events.dto.dart';
import 'package:taskpal/data/dtos/update_event.dto.dart';
import 'package:taskpal/data/repositories/events.repository.dart';
import 'package:taskpal/domain/event.dart';

class EventsService {
  EventsService(this.eventsRepository);

  final EventsRepository eventsRepository;

  Future<List<Event>> queryEvents(QueryEventsDto queryEventsDto) {
    return eventsRepository.queryEvents(queryEventsDto);
  }

  Future<Event> addEvent(AddEventDto addEventDto) async {
    return eventsRepository.addEvent(addEventDto);
  }

  Future<Event> updateEvent(UpdateEventDto updateEventDto) async {
    return eventsRepository.updateEvent(updateEventDto);
  }

  Future<void> deleteEvent(String id) async {
    await eventsRepository.deleteEvent(id);
  }
}
