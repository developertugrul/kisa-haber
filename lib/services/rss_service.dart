import 'dart:convert';
import 'package:http/http.dart' as http;

class RssService {
  static Future<List<Map<String, dynamic>>> fetchRssList() async {
    final response = await http.get(Uri.parse("https://api.tugrulyildirim.com/api/news/rss-list"));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((data) => {
        'name': data['name'],
        'url': data['url'],
      }).toList();
    } else {
      throw Exception('Failed to load RSS list');
    }
  }
}
