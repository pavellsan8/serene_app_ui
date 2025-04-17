import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/main/video_page_model.dart';
import '../../models/favourite/favourite_model.dart';
import '../../utils/api_url.dart';
import '../../utils/shared_preferences.dart';

class VideoFavouriteService {
  Future<FavouriteResponse<String>> addVideoFavourite(
      {required ItemFavouriteRequest request}) async {
    final url = Uri.parse("${EnvConfig.baseUrl}/api/v1/video-favourite");
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
      return FavouriteResponse<String>.fromJson(responseData, "video_id");
    } catch (e) {
      throw Exception("Failed to add video favourite: $e");
    }
  }

  Future<VideoResponse> getVideoData({String? email}) async {
    String baseUrl = "${EnvConfig.baseUrl}/api/v1/get-video-favourite-list";
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
          return VideoResponse.fromJson(jsonResponse);
        } catch (jsonError) {
          throw Exception('Failed to parse response: $jsonError');
        }
      } else {
        throw Exception('Failed to load videos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching videos: $e');
    }
  }

  Future<FavouriteResponse<String>> removeVideoFavourite(
      {required ItemFavouriteRequest request}) async {
    final url = Uri.parse("${EnvConfig.baseUrl}/api/v1/video-favourite");
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
      return FavouriteResponse<String>.fromJson(responseData, "video_id");
    } catch (e) {
      throw Exception("Failed to remove video favourite: $e");
    }
  }
}
