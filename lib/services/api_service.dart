import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://opentdb.com/";

  static Future<List<dynamic>> fetchCategories() async {
    final response = await http.get(Uri.parse("${baseUrl}api_category.php"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['trivia_categories'];
    } else {
      throw Exception("Failed to load categories");
    }
  }

  static Future<List<dynamic>> fetchQuestions(Map<String, String> queryParams) async {
    final uri = Uri.parse("${baseUrl}api.php").replace(queryParameters: queryParams);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'];
    } else {
      throw Exception("Failed to load questions");
    }
  }
}
