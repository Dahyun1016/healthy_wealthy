import 'package:flutter/material.dart';
import 'user_info_section.dart';
import 'saved_items_section.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          UserInfoSection(),
          SavedItemsSection(),
        ],
      ),
    );
  }
}