import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'event.g.dart';

@HiveType(typeId: 0)
class Event extends Equatable {
  const Event({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.isCompleted,
    required this.color,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime startTime;

  @HiveField(3)
  final DateTime endTime;

  @HiveField(4)
  final bool isCompleted;

  @HiveField(5)
  final EventColor color;

  @override
  List<Object?> get props => [id, title, startTime, endTime, isCompleted, color];
}

@HiveType(typeId: 1)
enum EventColor {
  @HiveField(0)
  red,
  @HiveField(1)
  orange,
  @HiveField(2)
  blue,
  @HiveField(3)
  indigo,
  @HiveField(4)
  purple,
  @HiveField(5)
  green,
  @HiveField(6)
  lime,
  @HiveField(7)
  teal,
  @HiveField(8)
  yellow,
  @HiveField(9)
  pink,
  @HiveField(10)
  grey,
  @HiveField(11)
  amber,
  @HiveField(12)
  brown,
  @HiveField(13)
  cyan,
}
