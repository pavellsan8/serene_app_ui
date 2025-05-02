import 'package:flutter/material.dart';
import 'package:serene_app/models/main/chabot_page_model.dart';

import '../../services/main/chatbot_page_service.dart';
import '../../widgets/main/chatbot/chat_bubble_widget.dart';

class ChatbotViewModel extends ChangeNotifier {
  final ChatbotService chatbotService = ChatbotService();
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final List<ChatMessage> messages = [];

  bool isLoading = false;

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    messages.add(
      ChatMessage(
        text: messageController.text,
        isUser: true,
      ),
    );

    String userMessage = messageController.text;
    messageController.clear();
    scrollToBottom();
    notifyListeners();

    getBotResponse(userMessage);
  }

  Future<void> getBotResponse(String input) async {
    isLoading = true; // Start loading
    notifyListeners();

    try {
      final request = ChatbotRequest(userInput: input);
      final response = await chatbotService.chatbotResponse(request);
      messages.add(
        ChatMessage(
          text: response.response,
          isUser: false,
        ),
      );
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      isLoading = false;
      scrollToBottom();
      notifyListeners();
    }
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
