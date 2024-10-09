import 'package:flutter/material.dart';
import 'package:timely/presentation/widgets/events/appbar.dart';
import 'package:timely/presentation/widgets/events/events.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const EventsAppbar(),
            Expanded(child: Events()),
          ],
        ),
      ),
    );
  }
}
