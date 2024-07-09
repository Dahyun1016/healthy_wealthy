import 'package:flutter/material.dart';
import 'search_section.dart';
import 'color_search_section.dart';
import 'recommended_supplements_section.dart';

class MedicineRecognitionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SearchSection(),
          Divider(),
          ColorSearchSection(),
          Divider(),
          RecommendedSupplementsSection(),
        ],
      ),
    );
  }
}
