import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class NearbyHospitalsSection extends StatefulWidget {
  final String apiKey;

  NearbyHospitalsSection({required this.apiKey});

  @override
  _NearbyHospitalsSectionState createState() => _NearbyHospitalsSectionState();
}

class _NearbyHospitalsSectionState extends State<NearbyHospitalsSection> {
  List<dynamic> hospitals = [];
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  Future<void> fetchLocation() async {
    try {
      var status = await Permission.location.status;
      if (status.isDenied) {
        await Permission.location.request();
      }

      if (await Permission.location.isGranted) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        setState(() {
          latitude = position.latitude;
          longitude = position.longitude;
        });
        fetchHospitals();
      } else {
        print('Location permission denied');
      }
    } catch (e) {
      print('Error fetching location: $e');
    }
  }

  Future<void> fetchHospitals() async {
    if (latitude == null || longitude == null) return;

    try {
      final hospitalResponse = await http.get(
        Uri.parse(
            'https://dapi.kakao.com/v2/local/search/keyword.json?query=병원&x=$longitude&y=$latitude&radius=1000'),
        headers: {"Authorization": "KakaoAK ${widget.apiKey}"},
      );

      if (hospitalResponse.statusCode == 200) {
        setState(() {
          hospitals = json.decode(hospitalResponse.body)['documents'];
        });
      } else {
        print('Failed to load hospitals: ${hospitalResponse.statusCode}');
      }
    } catch (e) {
      print('Error fetching hospitals: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            '내 근처 병원 찾기:',
            style: TextStyle(fontSize: 16),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: hospitals.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(hospitals[index]['place_name']),
                subtitle: Text(hospitals[index]['road_address_name'] ??
                    'No address available'),
              );
            },
          ),
        ],
      ),
    );
  }
}
