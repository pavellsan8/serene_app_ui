import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/questionnaire/emotion_list_model.dart';
import '../../utils/api_url.dart';
import '../../utils/shared_preferences.dart';

class EmotionListService {
  Future<List<EmotionListData>> getEmotionList() async {
    final url = Uri.parse("${EnvConfig.baseUrl}/api/v1/get-list-emotion");

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );

      // Check for HTTP error codes
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(response.body);

        final List<dynamic> dataList = jsonMap['data'];

        return dataList.map((json) => EmotionListData.fromJson(json)).toList();
      } else {
        throw Exception('Error fetching emotion list: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("Error fetching emotion list: $e");
    }
  }

  Future<List<EmotionListData>> getEmotionListUserAnswer() async {
    final url =
        Uri.parse("${EnvConfig.baseUrl}/api/v1/get-emotion-list-user-answer");
    final accessToken = await ApplicationStorage.getAccessToken();

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      // Check for HTTP error codes
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(response.body);

        final List<dynamic> dataList = jsonMap['data'];

        return dataList.map((json) => EmotionListData.fromJson(json)).toList();
      } else {
        throw Exception('Error fetching emotion list: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("Error fetching emotion list: $e");
    }
  }
}
