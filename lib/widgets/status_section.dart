import 'package:flutter/material.dart';

class StatusSection extends StatefulWidget {
  @override
  _StatusSectionState createState() => _StatusSectionState();
}

class _StatusSectionState extends State<StatusSection> {
  String _selectedStatus = '매우 좋음';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            '오늘의 건강 상태를 선택하세요:',
            style: TextStyle(fontSize: 16),
          ),
          DropdownButton<String>(
            value: _selectedStatus,
            onChanged: (String? newValue) {
              setState(() {
                _selectedStatus = newValue!;
              });
            },
            items: <String>['매우 좋음', '좋음', '양호', '나쁨', '아주나쁨']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
