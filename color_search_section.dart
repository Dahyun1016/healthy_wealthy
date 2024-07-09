import 'package:flutter/material.dart';

class ColorSearchSection extends StatelessWidget {
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
          Text('모양으로 검색하기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            children: List.generate(12, (index) {
              return Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('색상 ${index+1}'),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
