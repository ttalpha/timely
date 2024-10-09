import 'package:mobx_triple/mobx_triple.dart';
import 'package:timely/data/dtos/query_events.dto.dart';
import 'package:timely/domain/event.dart';

class QueryEventsParams {
  QueryEventsParams({
    this.keyword,
    this.startTime,
    this.endTime,
    this.isCompleted,
    this.colors,
  });

  final String? keyword;
  final DateTime? startTime;
  final DateTime? endTime;
  final bool? isCompleted;
  final Set<EventColor>? colors;
}

class EventsQueryStore extends MobXStore<QueryEventsDto> {
  EventsQueryStore() : super(QueryEventsDto(keyword: '', colors: <EventColor>{}));

  void setQuery(QueryEventsParams params) {
    update(
      QueryEventsDto(
        colors: params.colors ?? state.colors,
        keyword: params.keyword ?? state.keyword,
        startTime: params.startTime ?? state.startTime,
        endTime: params.endTime ?? state.endTime,
        isCompleted: params.isCompleted ?? state.isCompleted,
      ),
    );
  }

  void setDateQuery(int date, int month, int year) {
    var startOfDate = DateTime(year, month, date);
    var endOfDate = startOfDate.add(const Duration(days: 1));

    setQuery(QueryEventsParams(startTime: startOfDate, endTime: endOfDate));
  }

  void resetQuery() {
    setQuery(
      QueryEventsParams(
        colors: <EventColor>{},
        endTime: null,
        isCompleted: null,
        keyword: '',
        startTime: null,
      ),
    );
  }
}
