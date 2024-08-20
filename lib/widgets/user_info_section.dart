import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserInfoSection extends StatefulWidget {
  final String userId;

  UserInfoSection({required this.userId});

  @override
  _UserInfoSectionState createState() => _UserInfoSectionState();
}

class _UserInfoSectionState extends State<UserInfoSection> {
  String name = '';
  String gender = '';
  int age = 0;
  bool isLoading = true; // 로딩 상태를 추적

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:3000/user/info?userId=${widget.userId}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // 성별을 한글로 변환
        String genderKorean;
        if (data['gender'] == 'Male') {
          genderKorean = '남';
        } else if (data['gender'] == 'Female') {
          genderKorean = '여';
        } else {
          genderKorean = '기타'; // 필요에 따라 'Other' 처리
        }

        setState(() {
          name = data['name'];
          gender = genderKorean;
          age = data['age'];
          isLoading = false; // 로딩 완료
        });
      } else {
        print('Failed to load user info: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '내 정보',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
              radius: 24,
            ),
            title: isLoading
                ? Text('Loading...',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                : Text(name,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            subtitle: isLoading
                ? Text('Loading...', style: TextStyle(fontSize: 14))
                : Text('만 $age세 ($gender)', style: TextStyle(fontSize: 14)),
            trailing: TextButton(
              onPressed: () {
                // 수정하기 버튼 클릭 시 수행할 동작 정의
              },
              child: Text('수정하기', style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
