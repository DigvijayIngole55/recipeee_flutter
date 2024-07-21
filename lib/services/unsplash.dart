import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UnsplashService {
  Future<String?> fetchImageUrl(String query) async {
    final unsplashAccessKey = dotenv.env['UNSPLASH_ACCESS_KEY'];

    final response = await http.get(
      Uri.parse(
          'https://api.unsplash.com/photos/random?query=$query&client_id=$unsplashAccessKey'),
    );
    print(
        'https://api.unsplash.com/photos/random?query=$query&client_id=$unsplashAccessKey');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final imageUrl = data['urls']['small'];
      print('Image URL fetched: $imageUrl');
      return imageUrl;
    } else {
      throw Exception('Failed to load image');
    }
  }
}
