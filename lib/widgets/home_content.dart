// 홈 탭의 주요 기능 구현하는 위젯 코드
import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  final List<dynamic> hospitals;

  HomeContent({required this.hospitals});

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
          Placeholder(fallbackHeight: 200), // 상태를 표시할 섹션
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '오늘의 복용 약',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Placeholder(fallbackHeight: 200), // 오늘의 복용 약을 표시할 섹션
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '내 근처 병원 찾기',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: hospitals.length < 2 ? hospitals.length : 2,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(hospitals[index]['place_name']),
                subtitle: Text(hospitals[index]['road_address_name'] ?? 'No address available'),
              );
            },
          ),
        ],
      ),
    );
  }
}
