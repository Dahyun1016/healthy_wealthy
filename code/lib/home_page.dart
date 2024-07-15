import 'package:flutter/material.dart';
import 'header.dart'; // header.dart 임포트
import 'bottom_navigation.dart'; // bottom_navigation.dart 임포트

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Text('캘린더'), // 캘린더 페이지
    Text('병원 찾기'), // 병원 찾기 페이지
    Text('홈'), // 홈 페이지
    Text('의약품'), // 의약품 페이지
    Text('마이페이지'), // 마이페이지
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CommonHeader(), // 공통 헤더 사용
          Expanded(
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
