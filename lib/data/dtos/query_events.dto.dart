import 'package:timely/domain/event.dart';

class QueryEventsDto {
  QueryEventsDto({
    required this.keyword,
    this.startTime,
    this.endTime,
    this.isCompleted,
    required this.colors,
  });

  final String keyword;
  final DateTime? startTime;
  final DateTime? endTime;
  final bool? isCompleted;
  final Set<EventColor> colors;
}
