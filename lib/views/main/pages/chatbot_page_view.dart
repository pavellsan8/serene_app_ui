import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../utils/routes.dart';
import '../../../widgets/main/chatbot/chat_input_widget.dart';
import '../../../widgets/main/chatbot/chat_bubble_widget.dart';
import '../../../viewmodels/main/chatbot_page_viewmodel.dart';

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatbotViewModel(),
      child: const _ChatbotPageContent(),
    );
  }
}

class _ChatbotPageContent extends StatelessWidget {
  const _ChatbotPageContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ChatbotViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.homePage,
              );
            },
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Image.asset(
                AppColors.getSerebotPath(context),
                width: 22,
              ),
            ),
            const SizedBox(width: 15),
            const Text(
              "Serebot",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: viewModel.messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 80,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Start the conversation with Serebot!",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: viewModel.scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: viewModel.messages.length +
                        (viewModel.isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == viewModel.messages.length &&
                          viewModel.isLoading) {
                        // Improved typing indicator
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            top: 8,
                            bottom: 8,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: const TypingIndicator(),
                              ),
                            ],
                          ),
                        );
                      }
                      return viewModel.messages[index];
                    },
                  ),
          ),
          ChatbotInputArea(
            controller: viewModel.messageController,
            onSend: viewModel.sendMessage,
          ),
        ],
      ),
    );
  }
}
