import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskpal/app/events.service.dart';
import 'package:taskpal/data/datasources/local_datasource.dart';
import 'package:taskpal/data/repositories/hive_events.repository.dart';
import 'package:taskpal/domain/event.dart';
import 'package:taskpal/presentation/pages/events_page.dart';
import 'package:taskpal/presentation/stores/events_query_store.dart';
import 'package:taskpal/presentation/stores/events_store.dart';
import 'package:uuid/uuid.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(EventAdapter());
  Hive.registerAdapter(EventColorAdapter());

  final eventsBox = await Hive.openBox<Event>('eventsBox');
  eventsBox.clear();

  getIt.registerSingleton<LocalDataSource<Event>>(LocalDataSource<Event>(eventsBox));
  getIt.registerSingleton<HiveEventsRepository>(
    HiveEventsRepository(getIt<LocalDataSource<Event>>()),
  );
  getIt.registerSingleton<EventsService>(
    EventsService(getIt<HiveEventsRepository>()),
  );
  getIt.registerSingleton<EventsStore>(
    EventsStore(getIt<EventsService>()),
  );
  getIt.registerSingleton<EventsQueryStore>(EventsQueryStore());
  runApp(const MyApp());
}

String generateRandomTitle() {
  List<String> words = [
    "Meeting",
    "Conference",
    "Workshop",
    "Session",
    "Discussion",
    "Update",
    "Planning",
    "Review",
    "Training",
    "Strategy",
    "Briefing",
    "Consultation",
    "Development",
    "Review",
    "Roundtable",
    "Sprint",
    "Alignment",
    "Integration",
    "Feedback",
    "Coordination",
    "Analysis",
    "Demo",
    "Retrospective",
    "Kick-off",
    "Follow-up"
  ];
  return (List.generate(10, (_) => words[Random().nextInt(words.length)])).join(" ").substring(0, 10);
}

// Function to generate random start and end times
Map<String, DateTime> generateRandomTimes() {
  DateTime startTime = DateTime.now().add(Duration(days: Random().nextInt(30), hours: Random().nextInt(24)));
  DateTime endTime = startTime.add(Duration(hours: Random().nextInt(5) + 1)); // End time after start time
  return {"startTime": startTime, "endTime": endTime};
}

// Function to generate a random color
EventColor getRandomColor() {
  List<EventColor> colors = EventColor.values;
  return colors[Random().nextInt(colors.length)];
}

// Generate 10 random events
List<Event> generateEvents() {
  Uuid uuid = const Uuid();
  List<Event> events = [];

  for (int i = 0; i < 32; i++) {
    Map<String, DateTime> times = generateRandomTimes();
    events.add(Event(
      id: uuid.v4(),
      title: generateRandomTitle(),
      startTime: times['startTime']!,
      endTime: times['endTime']!,
      isCompleted: Random().nextBool(),
      color: getRandomColor(),
    ));
  }
  return events;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  Future<void> seedEvents() async {
    List<Event> events = generateEvents();
    final localDataSource = getIt<LocalDataSource<Event>>();
    for (var event in events) {
      await localDataSource.saveData(event.id, event);
    }
  }

  @override
  void initState() {
    super.initState();
    seedEvents();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timely - Manage your time effectively',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const EventsPage(),
    );
  }
}
