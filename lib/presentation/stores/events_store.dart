import 'package:mobx_triple/mobx_triple.dart';
import 'package:timely/app/events.service.dart';
import 'package:timely/data/dtos/add_event.dto.dart';
import 'package:timely/data/dtos/query_events.dto.dart';
import 'package:timely/data/dtos/update_event.dto.dart';
import 'package:timely/domain/event.dart';

class EventsStore extends MobXStore<List<Event>> {
  EventsStore(this.eventsService) : super(<Event>[]);

  final EventsService eventsService;

  Future<void> fetchEvents(QueryEventsDto queryEventsDto) async {
    final events = await eventsService.queryEvents(queryEventsDto);
    update(events);
  }

  Future<void> addEvent(AddEventDto addEventDto) async {
    final updatedState = List<Event>.from(state);
    final newEvent = await eventsService.addEvent(addEventDto);
    updatedState.add(newEvent);
    update(updatedState);
  }

  Future<void> updateEvent(UpdateEventDto updateEventDto) async {
    final index = state.indexWhere((ev) => ev.id == updateEventDto.id);
    if (index > -1) {
      final updatedState = List<Event>.from(state);
      final updatedEvent = await eventsService.updateEvent(updateEventDto);
      updatedState[index] = updatedEvent;
      update(updatedState);
    } else {
      setError(Exception('Cannot update event with id ${updateEventDto.id} because it is not found'));
    }
  }

  Future<void> deleteEvent(String id) async {
    final index = state.indexWhere((ev) => ev.id == id);
    if (index > -1) {
      final updatedState = List<Event>.from(state);
      updatedState.removeAt(index);
      await eventsService.deleteEvent(id);
      update(updatedState);
    } else {
      setError(Exception('Cannot delete event with id $id because it is not found'));
    }
  }
}
