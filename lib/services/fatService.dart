import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ImageService {
  final String _baseUrl = 'http://localhost:8080/images/fetch-image';

  Future<String?> fetchImageUrl(String query) async {
    final uri = Uri.parse('$_baseUrl?query=${Uri.encodeComponent(query)}');

    print('Request URL: $uri');
    try {
      final response = await http.get(uri);

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Parsed Response Data: $data');
        if (data['imageUrl'] != null) {
          final imageUrl = data['imageUrl'];
          print('Image URL fetched: $imageUrl');
          return imageUrl;
        } else {
          print('No image URL found in the response.');
          return null;
        }
      } else {
        print('Failed to fetch image URL. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('HTTP request failed: $e');
      return null;
    }
  }
}
