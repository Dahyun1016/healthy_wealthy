import 'package:flutter/material.dart';
import '../widgets/review_section.dart';
import '../widgets/recommended_supplements_section.dart';

class SupplementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ReviewSection(),
          RecommendedSupplementsSection(),
        ],
      ),
    );
  }
}
