import 'package:flutter/material.dart';

import '../../../widgets/main/chat_bubble_widget.dart';

class ChatbotViewModel extends ChangeNotifier {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final List<ChatMessage> messages = [];

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

    Future.delayed(const Duration(seconds: 1), () {
      messages.add(
        ChatMessage(
          text: "Ini adalah respons dari Serebot untuk: $userMessage",
          isUser: false,
        ),
      );
      scrollToBottom();
      notifyListeners();
    });
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
