import 'package:flutter/material.dart';
import 'status_section.dart';
import 'today_intake_section.dart';
import 'nearby_hospitals_section.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StatusSection(),
          TodayIntakeSection(),
          NearbyHospitalsSection(),
        ],
      ),
    );
  }
}
