import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // HTTP 요청을 위해 추가
import 'dart:convert'; // JSON 처리
import 'register_page.dart';
import 'home_page.dart'; // HomePage를 임포트

class LoginPage extends StatelessWidget {
  final String apiKey;

  LoginPage({required this.apiKey});

  @override
  Widget build(BuildContext context) {
    // ID와 Password를 입력받기 위한 TextEditingController를 생성
    TextEditingController idController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: idController, // ID 입력 필드
              decoration: InputDecoration(labelText: 'ID'),
            ),
            TextField(
              controller: passwordController, // Password 입력 필드
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // 로그인 로직 추가
                String id = idController.text;
                String password = passwordController.text;

                // 서버로 로그인 요청 보내기
                var url = Uri.parse('http://localhost:3000/login'); // 실제 서버 URL로 변경
                var response = await http.post(
                  url,
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    'userId': id,
                    'password': password,
                  }),
                );

                if (response.statusCode == 200) {
                  // 로그인 성공 시 홈 페이지로 이동
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage(apiKey: apiKey, userId: id)),
                  );
                } else {
                  // 로그인 실패 처리
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('로그인에 실패했습니다. 다시 시도해 주세요.')),
                  );
                }
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}


