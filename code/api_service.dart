import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String kakaoApiKey = 'YOUR_KAKAO_API_KEY';

  Future<List<dynamic>> getNearbyPlaces(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://dapi.kakao.com/v2/local/search/category.json?category_group_code=HP8&x=$longitude&y=$latitude&radius=2000');
    final response = await http.get(
      url,
      headers: {'Authorization': 'KakaoAK $kakaoApiKey'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['documents'];
    } else {
      throw Exception('Failed to load nearby places');
    }
  }
}
