import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/main/music_page_model.dart';
import '../../models/favourite/favourite_model.dart';
import '../../utils/api_url.dart';
import '../../utils/shared_preferences.dart';

class MusicFavouriteService {
  Future<FavouriteResponse<String>> addMusicFavourite(
      {required ItemFavouriteRequest request}) async {
    final url = Uri.parse("${EnvConfig.baseUrl}/api/v1/music-favourite");
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
      return FavouriteResponse<String>.fromJson(responseData, "music_id");
    } catch (e) {
      throw Exception("Failed to add music favourite: $e");
    }
  }

  Future<MusicResponse> getMusicData({String? email}) async {
    String baseUrl = "${EnvConfig.baseUrl}/api/v1/get-music-favourite-list";
    String finalUrl =
        "$baseUrl?email=${email?.isNotEmpty == true ? email : await ApplicationStorage.getEmail()}";
    final accessToken = await ApplicationStorage.getAccessToken();

    final url = Uri.parse(finalUrl);
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
          return MusicResponse.fromJson(jsonResponse);
        } catch (jsonError) {
          throw Exception('Failed to parse response: $jsonError');
        }
      } else {
        throw Exception('Failed to load musics: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching musics: $e');
    }
  }

  Future<FavouriteResponse<String>> removeMusicFavourite(
      {required ItemFavouriteRequest request}) async {
    final url = Uri.parse("${EnvConfig.baseUrl}/api/v1/music-favourite");
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
      return FavouriteResponse<String>.fromJson(responseData, "music_id");
    } catch (e) {
      throw Exception("Failed to remove music favourite: $e");
    }
  }
}
