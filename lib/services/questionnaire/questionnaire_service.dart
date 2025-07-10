import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/questionnaire/questionnaire_model.dart';
import '../../utils/api_url.dart';

class QuestionnaireInputService {
  Future<QuestionnaireResponse> submitQuestionnaire(
      QuestionnaireRequest request) async {
    final url =
        Uri.parse("${EnvConfig.baseUrl}/api/v1/user-questionnaire-answer");
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(request.toJson()),
      );

      final responseData = jsonDecode(response.body);
      return QuestionnaireResponse.fromJson(responseData);
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<QuestionnaireResponse> updateQuestionnaire(
      QuestionnaireRequest request) async {
    final url =
        Uri.parse("${EnvConfig.baseUrl}/api/v1/user-questionnaire-answer");

    try {
      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(request.toJson()),
      );

      final responseData = jsonDecode(response.body);
      return QuestionnaireResponse.fromJson(responseData);
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
