import 'package:taskpal/data/dtos/query_events.dto.dart';
import 'package:taskpal/data/repositories/events.repository.dart';
import 'package:taskpal/domain/event.dart';

class EventsService {
  EventsService(this.eventsRepository);

  final EventsRepository eventsRepository;

  Future<List<Event>> queryEvents(QueryEventsDto queryEventsDto) {
    return eventsRepository.queryEvents(queryEventsDto);
  }

  Future<void> addEvent(Event event) async {
    await eventsRepository.addEvent(event);
  }

  Future<void> updateEvent(Event event) async {
    await eventsRepository.updateEvent(event);
  }

  Future<void> deleteEvent(String id) async {
    await eventsRepository.deleteEvent(id);
  }
}
