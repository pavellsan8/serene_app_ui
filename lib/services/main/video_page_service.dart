import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/main/video_page_model.dart';
import '../../utils/api_url.dart';

class VideoService {
  Future<VideoResponse> getVideoData({String? query}) async {
    String baseUrl = "${EnvConfig.baseUrl}/api/v1/get-video-list";
    String finalUrl =
        "$baseUrl?query=${query?.isNotEmpty == true ? query : 'relaxing'}";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("access_token");

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
        return VideoResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load Videos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching Videos: $e');
    }
  }
}
