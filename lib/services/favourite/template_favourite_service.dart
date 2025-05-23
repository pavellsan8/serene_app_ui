import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/api_url.dart';
import '../../models/favourite/favourite_model.dart';
import '../../utils/shared_preferences.dart';

abstract class BaseFavouriteService<T> {
  final String entity; // e.g., "book", "music", "video"
  final String idKey; // e.g., "book_id", "music_id", "video_id"

  BaseFavouriteService(this.entity, this.idKey);

  Future<FavouriteResponse<String>> addFavourite(
      {required ItemFavouriteRequest request}) async {
    final url = Uri.parse("${EnvConfig.baseUrl}/api/v1/$entity-favourite");
    final accessToken = await ApplicationStorage.getAccessToken();

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode(request.toJson()),
      );

      final responseData = jsonDecode(response.body);
      return FavouriteResponse<String>.fromJson(responseData, idKey);
    } catch (e) {
      throw Exception("Failed to add $entity favourite: $e");
    }
  }

  Future<FavouriteResponse<String>> removeFavourite(
      {required ItemFavouriteRequest request}) async {
    final url = Uri.parse("${EnvConfig.baseUrl}/api/v1/$entity-favourite");
    final accessToken = await ApplicationStorage.getAccessToken();

    try {
      final response = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode(request.toJson()),
      );

      final responseData = jsonDecode(response.body);
      return FavouriteResponse<String>.fromJson(responseData, idKey);
    } catch (e) {
      throw Exception("Failed to remove $entity favourite: $e");
    }
  }

  Future<T> getData({String? email}) async {
    final url =
        Uri.parse("${EnvConfig.baseUrl}/api/v2/get-$entity-favourite-list");
    final accessToken = await ApplicationStorage.getAccessToken();

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          return parseResponse(jsonResponse);
        } catch (jsonError) {
          throw Exception('Failed to parse $entity response: $jsonError');
        }
      } else {
        throw Exception('Failed to load $entity: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching $entity: $e');
    }
  }

  T parseResponse(Map<String, dynamic> json);
}
