import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/status_section.dart';
import '../widgets/today_intake_section.dart';
import '../widgets/nearby_hospitals_section.dart';
import 'calendar_page.dart';
import 'medicine_page.dart';

class HomePage extends StatefulWidget {
  final String apiKey; // Add this line

  HomePage({required this.apiKey}); // Update the constructor

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;

  late List<Widget> _widgetOptions; // Define as late

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      CalendarPage(), // 캘린더 페이지
      NearbyHospitalsSection(apiKey: widget.apiKey), // 병원 찾기 페이지
      HomeContent(apiKey: widget.apiKey), // 홈 페이지
      MedicinePage(), // 의약품 페이지
      Text('마이페이지'), // 마이페이지
    ];
  }

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

class HomeContent extends StatelessWidget {
  final String apiKey;

  HomeContent({required this.apiKey});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '오늘의 건강 상태',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          StatusSection(), // 건강 상태 섹션 위젯
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '오늘의 복용 약',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          TodayIntakeSection(), // 오늘의 복용 약 섹션 위젯
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '내 근처 병원 찾기',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          NearbyHospitalsSection(apiKey: apiKey), // 근처 병원 섹션 위젯
        ],
      ),
    );
  }
}
