import 'package:taskpal/domain/event.dart';

class UpdateEventDto {
  UpdateEventDto({
    required this.id,
    this.title,
    this.startTime,
    this.endTime,
    this.isCompleted,
    this.color,
  });

  final String id;
  final String? title;
  final DateTime? startTime;
  final DateTime? endTime;
  final bool? isCompleted;
  final EventColor? color;
}
