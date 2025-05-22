import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class ChatbotInputArea extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatbotInputArea({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.getBackgroundColor(context),
        boxShadow: [
          BoxShadow(
            color: AppColors.getCardColor(context),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Text input field
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Type your message...",
                hintStyle: TextStyle(
                  color: AppColors.getSubtitleColor(context),
                  fontFamily: 'Montserrat',
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.getCardColor(context),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
                color: AppColors.getFontColor(context),
              ),
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: (_) => onSend(),
              maxLines: 5,
              minLines: 1,
            ),
          ),
          const SizedBox(width: 8),
          // Send button
          Container(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.send_rounded,
                color: Colors.white,
              ),
              onPressed: onSend,
            ),
          ),
        ],
      ),
    );
  }
}
