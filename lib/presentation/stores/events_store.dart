import 'package:mobx_triple/mobx_triple.dart';
import 'package:taskpal/app/events.service.dart';
import 'package:taskpal/data/dtos/add_event.dto.dart';
import 'package:taskpal/data/dtos/query_events.dto.dart';
import 'package:taskpal/data/dtos/update_event.dto.dart';
import 'package:taskpal/domain/event.dart';
import 'package:uuid/uuid.dart';

class EventsStore extends MobXStore<List<Event>> {
  EventsStore(this.eventsService) : super(<Event>[]);

  final EventsService eventsService;

  Future<void> fetchEvents(QueryEventsDto queryEventsDto) async {
    final events = await eventsService.queryEvents(queryEventsDto);
    update(events);
  }

  Future<void> addEvent(AddEventDto addEventDto) async {
    const uuid = Uuid();

    final updatedState = List<Event>.from(state);
    final newEvent = Event(
      id: uuid.v4(),
      title: addEventDto.title,
      startTime: addEventDto.startTime,
      endTime: addEventDto.endTime,
      isCompleted: false,
      color: addEventDto.color,
    );
    updatedState.add(newEvent);
    await eventsService.addEvent(newEvent);
    update(updatedState);
  }

  Future<void> updateEvent(UpdateEventDto updateEventDto) async {
    final index = state.indexWhere((ev) => ev.id == updateEventDto.id);
    if (index > -1) {
      final oldEvent = state[index];
      final updatedState = List<Event>.from(state);
      final updatedEvent = Event(
        id: oldEvent.id,
        title: updateEventDto.title ?? oldEvent.title,
        startTime: updateEventDto.startTime ?? oldEvent.startTime,
        endTime: updateEventDto.endTime ?? oldEvent.endTime,
        isCompleted: updateEventDto.isCompleted ?? oldEvent.isCompleted,
        color: updateEventDto.color ?? oldEvent.color,
      );
      updatedState[index] = updatedEvent;
      await eventsService.updateEvent(updatedEvent);
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
