import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final String apiKey = dotenv.env['TMDB_API_KEY']!;
  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<List<dynamic>> fetchMovies(String category) async {
    try {
      final url = Uri.parse(
        '$baseUrl/movie/$category?api_key=$apiKey',
      );

      final response = await http.get(url);

      print("=== TMDB RAW RESPONSE ===");
      print(response.body);

      if (response.statusCode == 200) {
        return json.decode(response.body)['results'];
      } else {
        throw Exception("Failed to fetch movies");
      }
    } catch (e) {
      rethrow;
    }
  }
}
