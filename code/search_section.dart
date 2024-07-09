import 'package:flutter/material.dart';

class SearchSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '사진을 찍어 약물을 검색해 보세요!',
              suffixIcon: IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () {},
              ),
            ),
          ),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '앨범에서 검색',
              suffixIcon: IconButton(
                icon: Icon(Icons.photo_album),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
