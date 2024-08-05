import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String apiKey =
        '6b12f48de8dd9be93bf69d3b805fa3f6'; // 여기에 실제 카카오 API 키를 입력

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white, // 앱 전체 배경색을 하얀색으로 설정
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white, // AppBar 배경색을 하얀색으로 설정
          iconTheme: IconThemeData(color: Colors.black),
          toolbarTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ), // toolbar 텍스트 스타일 설정
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ), // title 텍스트 스타일 설정
          elevation: 0, // AppBar 그림자를 제거하여 평면으로 만듦
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white, // BottomNavigationBar 배경색을 하얀색으로 설정
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: LoginPage(
        apiKey: apiKey, // 실제 API 키 전달
      ),
    );
  }
}
