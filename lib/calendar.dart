import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _events = {};
  List<String> _selectedEvents = [];
  Map<DateTime, String> _moods = {};

  @override
  void initState() {
    super.initState();
    _selectedEvents = _events[_selectedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedEvents = _events[_selectedDay] ?? [];
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: (day) {
              return _events[day] ?? [];
            },
          ),
          ..._selectedEvents.map((event) => ListTile(
                title: Text(event),
              )),
          ElevatedButton(
            onPressed: () => _addEvent(context),
            child: Text('Add Event'),
          ),
          ElevatedButton(
            onPressed: () => _addMood(context),
            child: Text('Add Mood'),
          ),
        ],
      ),
    );
  }

  void _addEvent(BuildContext context) {
    TextEditingController _eventController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Event'),
        content: TextField(
          controller: _eventController,
          decoration: InputDecoration(hintText: 'Enter event'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_eventController.text.isEmpty) return;
              setState(() {
                if (_events[_selectedDay] != null) {
                  _events[_selectedDay]!.add(_eventController.text);
                } else {
                  _events[_selectedDay!] = [_eventController.text];
                }
                _selectedEvents = _events[_selectedDay] ?? [];
              });
              Navigator.pop(context);
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void _addMood(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Mood'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.sentiment_very_satisfied),
              title: Text('Happy'),
              onTap: () => _setMood('Happy'),
            ),
            ListTile(
              leading: Icon(Icons.sentiment_dissatisfied),
              title: Text('Sad'),
              onTap: () => _setMood('Sad'),
            ),
            ListTile(
              leading: Icon(Icons.sentiment_neutral),
              title: Text('Neutral'),
              onTap: () => _setMood('Neutral'),
            ),
            ListTile(
              leading: Icon(Icons.sentiment_very_dissatisfied),
              title: Text('Angry'),
              onTap: () => _setMood('Angry'),
            ),
            ListTile(
              leading: Icon(Icons.sentiment_satisfied),
              title: Text('Excited'),
              onTap: () => _setMood('Excited'),
            ),
          ],
        ),
      ),
    );
  }

  void _setMood(String mood) {
    setState(() {
      _moods[_selectedDay!] = mood;
    });
    Navigator.pop(context);
  }
}
