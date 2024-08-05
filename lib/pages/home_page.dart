import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/status_section.dart';
import '../widgets/today_intake_section.dart';
import '../widgets/nearby_hospitals_section.dart';
import 'calendar_page.dart';
import 'medicine_page.dart';

class HomePage extends StatefulWidget {
  final String userId; // 사용자 ID 추가
  final String apiKey;

  HomePage({required this.userId, required this.apiKey}); // 사용자 ID 추가

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      CalendarPage(userId: widget.userId), // 사용자 ID 전달
      NearbyHospitalsSection(apiKey: widget.apiKey),
      HomeContent(userId: widget.userId, apiKey: widget.apiKey), // 사용자 ID 전달
      MedicinePage(),
      Text('마이페이지'),
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
          CommonHeader(),
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
  final String userId; // 사용자 ID 추가
  final String apiKey;

  HomeContent({required this.userId, required this.apiKey}); // 사용자 ID 추가

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
          StatusSection(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '오늘의 복용 약',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          TodayIntakeSection(userId: userId), // 사용자 ID 전달
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '내 근처 병원 찾기',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          NearbyHospitalsSection(apiKey: apiKey),
        ],
      ),
    );
  }
}
