// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventAdapter extends TypeAdapter<Event> {
  @override
  final int typeId = 0;

  @override
  Event read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Event(
      id: fields[0] as String,
      title: fields[1] as String,
      startTime: fields[2] as DateTime,
      endTime: fields[3] as DateTime,
      isCompleted: fields[4] as bool,
      color: fields[5] as EventColor,
    );
  }

  @override
  void write(BinaryWriter writer, Event obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.endTime)
      ..writeByte(4)
      ..write(obj.isCompleted)
      ..writeByte(5)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EventColorAdapter extends TypeAdapter<EventColor> {
  @override
  final int typeId = 1;

  @override
  EventColor read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EventColor.red;
      case 1:
        return EventColor.orange;
      case 2:
        return EventColor.blue;
      case 3:
        return EventColor.indigo;
      case 4:
        return EventColor.purple;
      case 5:
        return EventColor.green;
      case 6:
        return EventColor.lime;
      case 7:
        return EventColor.teal;
      case 8:
        return EventColor.yellow;
      case 9:
        return EventColor.pink;
      case 10:
        return EventColor.grey;
      case 11:
        return EventColor.amber;
      case 12:
        return EventColor.brown;
      case 13:
        return EventColor.cyan;
      default:
        return EventColor.red;
    }
  }

  @override
  void write(BinaryWriter writer, EventColor obj) {
    switch (obj) {
      case EventColor.red:
        writer.writeByte(0);
        break;
      case EventColor.orange:
        writer.writeByte(1);
        break;
      case EventColor.blue:
        writer.writeByte(2);
        break;
      case EventColor.indigo:
        writer.writeByte(3);
        break;
      case EventColor.purple:
        writer.writeByte(4);
        break;
      case EventColor.green:
        writer.writeByte(5);
        break;
      case EventColor.lime:
        writer.writeByte(6);
        break;
      case EventColor.teal:
        writer.writeByte(7);
        break;
      case EventColor.yellow:
        writer.writeByte(8);
        break;
      case EventColor.pink:
        writer.writeByte(9);
        break;
      case EventColor.grey:
        writer.writeByte(10);
        break;
      case EventColor.amber:
        writer.writeByte(11);
        break;
      case EventColor.brown:
        writer.writeByte(12);
        break;
      case EventColor.cyan:
        writer.writeByte(13);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventColorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
