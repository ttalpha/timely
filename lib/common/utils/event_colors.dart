import 'package:flutter/material.dart';
import 'package:taskpal/domain/event.dart';

class EventColorsUtils {
  static MaterialColor mapColorToObject(EventColor color) {
    switch (color) {
      case EventColor.blue:
        return Colors.blue;
      case EventColor.green:
        return Colors.green;
      case EventColor.indigo:
        return Colors.indigo;
      case EventColor.lime:
        return Colors.lime;
      case EventColor.orange:
        return Colors.orange;
      case EventColor.pink:
        return Colors.pink;
      case EventColor.purple:
        return Colors.purple;
      case EventColor.red:
        return Colors.red;
      case EventColor.teal:
        return Colors.teal;
      case EventColor.yellow:
        return Colors.yellow;
      case EventColor.amber:
        return Colors.amber;
      case EventColor.cyan:
        return Colors.cyan;
      case EventColor.brown:
        return Colors.brown;
      case EventColor.grey:
        return Colors.grey;
      default:
        throw Exception('Color provided is not in the list of available colors');
    }
  }

  static Set<EventColor> getPossibleColors() {
    return EventColor.values.toSet();
  }
}
