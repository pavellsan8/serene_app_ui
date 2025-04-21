import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/main/music_page_model.dart';
import '../../utils/api_url.dart';
import '../../utils/shared_preferences.dart';

class MusicService {
  Future<MusicResponse> getMusicData({String? search}) async {
    String baseUrl = "${EnvConfig.baseUrl}/api/v1/get-music-list";
    String finalUrl =
        "$baseUrl?search=${search?.isNotEmpty == true ? search : 'chill'}";

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
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return MusicResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load Musics: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching Musics: $e');
    }
  }
}
