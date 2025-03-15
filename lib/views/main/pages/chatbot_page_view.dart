import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../utils/routes.dart';
import '../../../widgets/main/chat_input_widget.dart';
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.homePage);
            },
          ),
        ),
        title: const Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.backgroundColor,
              child: Icon(Icons.smart_toy, color: AppColors.primaryColor),
            ),
            SizedBox(width: 15),
            Text(
              "Serebot",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
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
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Start the conversation with Serebot!",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: viewModel.scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: viewModel.messages.length,
                    itemBuilder: (context, index) {
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