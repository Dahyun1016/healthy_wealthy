import 'package:flutter/material.dart';

class SavedItemsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 여기에 SavedItemsSection의 구현 내용을 추가하세요.
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '찜한 약',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          // 약품 목록 또는 기타 내용을 여기에 추가합니다.
        ],
      ),
    );
  }
}
