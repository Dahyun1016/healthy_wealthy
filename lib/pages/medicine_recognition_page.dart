import 'package:flutter/material.dart';
import '../widgets/search_section.dart';
import '../widgets/color_search_section.dart';
import '../widgets/recommended_supplements_section.dart';

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
