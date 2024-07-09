import 'package:flutter/material.dart';

class TodayIntakeSection extends StatelessWidget {
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
          Text('오늘의 복용', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('잊은 약은 없는지 체크하세요.'),
          SizedBox(height: 8),
          ListTile(
            leading: Image.network('https://via.placeholder.com/150'), // 실제 이미지 URL
            title: Text('가네리버연질캡슐175mg'),
            subtitle: Text('1정'),
            trailing: Checkbox(value: true, onChanged: (bool? value) {}),
          ),
          ListTile(
            leading: Image.network('https://via.placeholder.com/150'), // 실제 이미지 URL
            title: Text('가네리드정'),
            subtitle: Text('1정'),
            trailing: Checkbox(value: false, onChanged: (bool? value) {}),
          ),
        ],
      ),
    );
  }
}
