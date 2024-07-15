import 'package:flutter/material.dart';

class CommonHeader extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      flexibleSpace: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Image.asset(
                  'assets/logo.png',
                  height: 40,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '사진을 찍어 약물을 검색해 보세요!',
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white, // 검색바 배경색을 하얀색으로 설정
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(30.0), // 둥근 테두리 설정
                          borderSide:
                              BorderSide(color: Colors.grey), // 테두리 색을 회색으로 설정
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0), // 검색바와 카메라 아이콘 사이 간격 조절
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300], // 카메라 아이콘 배경색 설정
                    ),
                    child: IconButton(
                      icon: Icon(Icons.camera_alt),
                      color: Colors.black,
                      onPressed: () {
                        // 카메라 아이콘 클릭 시 동작 추가
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100.0); // AppBar 높이 설정
}
