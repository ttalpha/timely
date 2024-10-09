import 'package:taskpal/domain/event.dart';

class AddEventDto {
  AddEventDto({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.color,
  });

  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final EventColor color;
}
