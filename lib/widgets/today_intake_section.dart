import 'package:flutter/material.dart';

class TodayIntakeSection extends StatefulWidget {
  @override
  _TodayIntakeSectionState createState() => _TodayIntakeSectionState();
}

class _TodayIntakeSectionState extends State<TodayIntakeSection> {
  final List<String> _intakeList = [];

  final TextEditingController _controller = TextEditingController();

  void _addIntake(String intake) {
    setState(() {
      _intakeList.add(intake);
    });
    _controller.clear();
  }

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
            '오늘 복용할 약을 추가하세요:',
            style: TextStyle(fontSize: 16),
          ),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: '약 이름 입력',
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                _addIntake(_controller.text);
              }
            },
            child: Text('추가'),
          ),
          SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _intakeList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_intakeList[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}
