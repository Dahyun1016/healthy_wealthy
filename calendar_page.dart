import 'package:flutter/material.dart';
import 'calendar.dart';
import 'today_intake_section.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('오늘의 건강 상태', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Calendar(),
          TodayIntakeSection(),
        ],
      ),
    );
  }
}
