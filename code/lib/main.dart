import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.isNotEmpty ? cameras.first : null;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription? camera;

  MyApp({required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PharmacyFinder(camera: camera),
    );
  }
}

class PharmacyFinder extends StatefulWidget {
  final CameraDescription? camera;

  PharmacyFinder({required this.camera});

  @override
  _PharmacyFinderState createState() => _PharmacyFinderState();
}

class _PharmacyFinderState extends State<PharmacyFinder> {
  final String apiKey = '6b12f48de8dd9be93bf69d3b805fa3f6'; // 여기에 실제 카카오 API 키를 입력하세요.
  List<dynamic> pharmacies = [];
  List<dynamic> hospitals = [];
  double? latitude;
  double? longitude;
  CameraController? _cameraController;

  @override
  void initState() {
    super.initState();
    fetchLocation();
    if (widget.camera != null) {
      _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    if (widget.camera != null) {
      _cameraController = CameraController(
        widget.camera!,
        ResolutionPreset.high,
      );

      try {
        await _cameraController?.initialize();
      } catch (e) {
        print('Error initializing camera: $e');
      }
    }
  }

  Future<void> fetchLocation() async {
    try {
      // 위치 권한 요청
      var status = await Permission.location.status;
      if (status.isDenied) {
        await Permission.location.request();
      }

      // 위치 권한이 허용된 경우 위치 정보 가져오기
      if (await Permission.location.isGranted) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        setState(() {
          latitude = position.latitude;
          longitude = position.longitude;
        });
        // 현재 위치 정보 출력
        print('Current location: ($latitude, $longitude)');
        fetchPlaces();
      } else {
        // 권한이 거부된 경우 처리
        print('Location permission denied');
      }
    } catch (e) {
      print('Error fetching location: $e');
    }
  }

  Future<void> fetchPlaces() async {
    if (latitude == null || longitude == null) return;

    try {
      final pharmacyResponse = await http.get(
        Uri.parse(
            'https://dapi.kakao.com/v2/local/search/keyword.json?query=약국&x=$longitude&y=$latitude&radius=1000'),
        headers: {"Authorization": "KakaoAK $apiKey"},
      );

      final hospitalResponse = await http.get(
        Uri.parse(
            'https://dapi.kakao.com/v2/local/search/keyword.json?query=병원&x=$longitude&y=$latitude&radius=1000'),
        headers: {"Authorization": "KakaoAK $apiKey"},
      );

      if (pharmacyResponse.statusCode == 200 &&
          hospitalResponse.statusCode == 200) {
        setState(() {
          pharmacies = json.decode(pharmacyResponse.body)['documents'];
          hospitals = json.decode(hospitalResponse.body)['documents'];
        });
      } else {
        print(
            'Failed to load places: ${pharmacyResponse.statusCode}, ${hospitalResponse.statusCode}');
      }
    } catch (e) {
      print('Error fetching places: $e');
    }
  }

  void _takePicture() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        final image = await _cameraController?.takePicture();
        // 사진을 찍고 나서 처리 로직 추가
        print('Picture taken: ${image?.path}');
      } catch (e) {
        print('Error taking picture: $e');
      }
    } else {
      print('Camera not initialized or not available.');
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wealthy - Pharmacy Finder'),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _takePicture,
          ),
        ],
      ),
      body: latitude == null || longitude == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: pharmacies.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(pharmacies[index]['place_name']),
                        subtitle: Text(pharmacies[index]['road_address_name'] ??
                            'No address available'),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: hospitals.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(hospitals[index]['place_name']),
                        subtitle: Text(hospitals[index]['road_address_name'] ??
                            'No address available'),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
