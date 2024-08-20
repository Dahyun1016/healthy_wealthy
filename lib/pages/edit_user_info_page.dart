import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditUserInfoPage extends StatefulWidget {
  final String userId;

  EditUserInfoPage({required this.userId});

  @override
  _EditUserInfoPageState createState() => _EditUserInfoPageState();
}

class _EditUserInfoPageState extends State<EditUserInfoPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String _selectedGender = 'Male';

  Future<void> _saveUserInfo() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/update-user'),
        body: json.encode({
          'userId': widget.userId,
          'name': _nameController.text,
          'age': int.parse(_ageController.text),
          'gender': _selectedGender,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('정보가 성공적으로 수정되었습니다.')),
        );
        Navigator.of(context).pop(); // 수정 완료 후 이전 페이지로 돌아가기
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('정보 수정에 실패했습니다. 다시 시도해 주세요.')),
        );
      }
    } catch (e) {
      print('정보 수정 오류: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('정보 수정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: '이름'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: '나이'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: _selectedGender,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedGender = newValue!;
                });
              },
              items: <String>['Male', 'Female']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value == 'Male' ? '남' : '여'),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _saveUserInfo,
              child: Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}
