import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/main/book_page_model.dart';
import '../../utils/api_url.dart';
import '../../utils/shared_preferences.dart';

class BookService {
  Future<BookResponse> getBookData() async {
    String baseUrl = "${EnvConfig.baseUrl}/api/v2/get-book-list";

    final accessToken = await ApplicationStorage.getAccessToken();
    final url = Uri.parse(baseUrl);

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return BookResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load books: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching books: $e');
    }
  }
}
