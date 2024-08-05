import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  Future<void> _searchIntake(String searchTerm) async {
    if (!kIsWeb) {
      // 모바일 환경에서만 권한 요청
      var status = await Permission.location.status;
      if (status.isDenied) {
        if (await Permission.location.request().isGranted) {
          _fetchSearchResults(searchTerm);
        }
      } else if (status.isGranted) {
        _fetchSearchResults(searchTerm);
      }
    } else {
      // 웹 환경에서는 권한 요청 없이 검색 수행
      _fetchSearchResults(searchTerm);
    }
  }

  Future<void> _fetchSearchResults(String searchTerm) async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:3000/search?term=$searchTerm'));
      if (response.statusCode == 200) {
        setState(() {
          _searchResults =
              List<Map<String, dynamic>>.from(json.decode(response.body));
        });
      } else {
        throw Exception('Failed to load search results');
      }
    } catch (error) {
      print('Error fetching search results: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('검색 중 오류가 발생했습니다. 다시 시도해 주세요.')),
      );
    }
  }

  Widget _buildSearchResults() {
    return _searchResults.isNotEmpty
        ? Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final result = _searchResults[index];
                return ListTile(
                  leading: result['product_image'] != null
                      ? Image.network(result['product_image'],
                          width: 50, height: 50)
                      : Icon(Icons.image_not_supported),
                  title: Text(result['product_name']),
                  onTap: () {
                    Navigator.of(context).pop(result['product_name']);
                  },
                );
              },
            ),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('약 검색'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(hintText: '검색할 약 이름 입력'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _searchIntake(_searchController.text);
              },
              child: Text('검색'),
            ),
            SizedBox(height: 10),
            _buildSearchResults(),
          ],
        ),
      ),
    );
  }
}
