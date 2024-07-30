import 'package:flutter/material.dart';

class UserInfoSection extends StatelessWidget {
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
          Text('내 정보', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('동미랑'),
            subtitle: Text('만 19세 (여)'),
            trailing: ElevatedButton(
              onPressed: () {},
              child: Text('수정하기'),
            ),
          ),
        ],
      ),
    );
  }
}
