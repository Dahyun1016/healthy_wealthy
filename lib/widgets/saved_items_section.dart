import 'package:flutter/material.dart';

class SavedItemsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('찜한 약', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ListTile(
            leading: Image.network('https://via.placeholder.com/150'), // 실제 이미지 URL
            title: Text('영양제 1'),
            subtitle: Text('설명'),
          ),
          ListTile(
            leading: Image.network('https://via.placeholder.com/150'), // 실제 이미지 URL
            title: Text('영양제 2'),
            subtitle: Text('설명'),
          ),
        ],
      ),
    );
  }
}
