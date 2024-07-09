import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'location_service.dart';
import 'api_service.dart';

class NearbyHospitalsSection extends StatefulWidget {
  @override
  _NearbyHospitalsSectionState createState() => _NearbyHospitalsSectionState();
}

class _NearbyHospitalsSectionState extends State<NearbyHospitalsSection> {
  List<dynamic> _places = [];
  bool _loading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchNearbyPlaces();
  }

  Future<void> _fetchNearbyPlaces() async {
    setState(() {
      _loading = true;
    });
    try {
      LocationService locationService = LocationService();
      Position position = await locationService.getCurrentLocation();
      ApiService apiService = ApiService();
      List<dynamic> places = await apiService.getNearbyPlaces(position.latitude, position.longitude);
      setState(() {
        _places = places;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('내 근처 병원 찾기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          _loading
              ? Center(child: CircularProgressIndicator())
              : _error.isNotEmpty
                  ? Center(child: Text('Error: $_error'))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _places.length,
                      itemBuilder: (context, index) {
                        final place = _places[index];
                        return ListTile(
                          leading: Image.network(place['place_url']), // 병원 이미지 URL을 적절히 설정하세요.
                          title: Text(place['place_name']),
                          subtitle: Text(place['address_name']),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // 상세정보 버튼 클릭 시 실행할 코드
                            },
                            child: Text('상세정보'),
                          ),
                        );
                      },
                    ),
        ],
      ),
    );
  }
}
