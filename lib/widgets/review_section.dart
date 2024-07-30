import 'package:flutter/material.dart';

class ReviewSection extends StatelessWidget {
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
          Text('후기 작성하기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '후기 입력',
            ),
            maxLines: 4,
          ),
          SizedBox(height: 8),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              child: Text('작성하기'),
            ),
          ),
        ],
      ),
    );
  }
}
