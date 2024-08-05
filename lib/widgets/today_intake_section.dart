import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import '../pages/search_page.dart';

class TodayIntakeSection extends StatefulWidget {
  final String userId;

  TodayIntakeSection({required this.userId});

  @override
  _TodayIntakeSectionState createState() => _TodayIntakeSectionState();
}

class _TodayIntakeSectionState extends State<TodayIntakeSection> {
  List<Map<String, dynamic>> _intakeList = [];
  final TextEditingController _controller = TextEditingController();
  final String _today = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _loadMedications();
  }

  Future<void> _loadMedications() async {
    try {
      final response = await http.get(Uri.parse(
          'http://localhost:3000/user/medications?userId=${widget.userId}&date=$_today'));
      if (response.statusCode == 200) {
        setState(() {
          _intakeList =
              List<Map<String, dynamic>>.from(json.decode(response.body))
                  .map((med) => {
                        'name': med['name'],
                        'taken': med['taken'] == 1, // int를 bool로 변환
                      })
                  .toList();
        });
      } else {
        throw Exception('Failed to load medications');
      }
    } catch (error) {
      print('Error loading medications: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('약물 정보를 불러오는 중 오류가 발생했습니다. 다시 시도해 주세요.')),
      );
    }
  }

  Future<void> _saveMedications() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/user/medications'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userId': widget.userId,
          'medications': _intakeList
              .map(
                  (med) => {'name': med['name'], 'taken': med['taken'] ? 1 : 0})
              .toList(), // bool을 int로 변환
          'date': _today,
        }),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to save medications');
      }
    } catch (error) {
      print('Error saving medications: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('약물 정보를 저장하는 중 오류가 발생했습니다. 다시 시도해 주세요.')),
      );
    }
  }

  Future<void> _deleteMedication(String intake) async {
    try {
      final response = await http.delete(
        Uri.parse(
            'http://localhost:3000/user/medications?userId=${widget.userId}&medication=$intake&date=$_today'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        setState(() {
          _intakeList.removeWhere((med) => med['name'] == intake);
        });
      } else {
        throw Exception('Failed to delete medication');
      }
    } catch (error) {
      print('Error deleting medication: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('약물 정보를 삭제하는 중 오류가 발생했습니다. 다시 시도해 주세요.')),
      );
    }
  }

  void _addIntake(String intake) {
    setState(() {
      if (!_intakeList.any((med) => med['name'] == intake)) {
        _intakeList.add({
          'name': intake,
          'taken': false,
        });
      }
    });
    _controller.clear();
    _saveMedications();
  }

  void _toggleTaken(int index, bool value) {
    // 상태만 업데이트하고 중복 방지
    setState(() {
      _intakeList[index]['taken'] = value;
    });
    _saveMedications();
  }

  Future<void> _navigateToSearchPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchPage()),
    );

    if (result != null) {
      _addIntake(result);
    }
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
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    _addIntake(_controller.text);
                  }
                },
                child: Text('추가'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _navigateToSearchPage,
                child: Text('검색하기'),
              ),
            ],
          ),
          SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _intakeList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_intakeList[index]['name']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: _intakeList[index]['taken'],
                      onChanged: (value) {
                        if (value != null) {
                          _toggleTaken(index, value);
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteMedication(_intakeList[index]['name']);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
