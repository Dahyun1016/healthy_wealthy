import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class SearchSection extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  Future<void> _takePicture(BuildContext context) async {
    var cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      cameraStatus = await Permission.camera.request();
    }

    if (cameraStatus.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        // 이미지 전송 로직 추가
        File imageFile = File(image.path);
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://localhost:3000/analyze_image'),
        );
        request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

        var response = await request.send();
        if (response.statusCode == 200) {
          var responseData = await response.stream.bytesToString();
          var result = jsonDecode(responseData);
          print('분석 결과: $result');
          // 분석 결과를 UI에 반영하는 코드 추가
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('이미지 분석에 실패했습니다. 다시 시도해 주세요.')),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('카메라 접근 권한이 필요합니다.')),
      );
    }
  }

  Future<void> _pickFromGallery(BuildContext context) async {
    var galleryStatus = await Permission.photos.status;
    if (!galleryStatus.isGranted) {
      galleryStatus = await Permission.photos.request();
    }

    if (galleryStatus.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        File imageFile = File(image.path);
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://localhost:3000/analyze_image'),
        );
        request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

        var response = await request.send();
        if (response.statusCode == 200) {
          var responseData = await response.stream.bytesToString();
          var result = jsonDecode(responseData);
          print('분석 결과: $result');
          // 분석 결과를 UI에 반영하는 코드 추가
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('이미지 분석에 실패했습니다. 다시 시도해 주세요.')),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('갤러리 접근 권한이 필요합니다.')),
      );
    }
  }

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
                onPressed: () => _takePicture(context),
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
                onPressed: () => _pickFromGallery(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
