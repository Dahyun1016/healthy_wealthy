import 'package:flutter/material.dart';

class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Table(
        children: [
          TableRow(
            children: List.generate(7, (index) => Center(child: Text('S'))),
          ),
          // Add more TableRows to complete the calendar
        ],
      ),
    );
  }
}
