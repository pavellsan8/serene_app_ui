import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/shared_preferences.dart';
import '../../models/main/chabot_page_model.dart';
import '../../utils/api_url.dart';

class ChatbotService {
  Future<ChatbotResponse> chatbotResponse(ChatbotRequest request) async {
    final url = Uri.parse("${EnvConfig.baseUrl}/api/v1/chatbot-response");
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
      return ChatbotResponse.fromJson(responseData);
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
