import 'package:flutter/material.dart';
import '../widgets/user_info_section.dart';
import '../widgets/saved_items_section.dart';

class MyPage extends StatelessWidget {
  final String userId;

  MyPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserInfoSection(userId: userId), // UserInfoSection에 userId 전달
            SizedBox(height: 16),
            SavedItemsSection(),
          ],
        ),
      ),
    );
  }
}
