import 'package:flutter/material.dart';
import '../../../../utils/colors.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({
    super.key,
    required this.text,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            // CircleAvatar(
            //   radius: 16,
            //   backgroundColor: AppColors.primaryColor.withOpacity(0.2),
            //   child: const Icon(Icons.smart_toy,
            //       color: AppColors.primaryColor, size: 18),
            // ),
            const SizedBox(width: 8),
          ],
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: isUser ? AppColors.primaryColor : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isUser ? Colors.white : Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            // CircleAvatar(
            //   radius: 16,
            //   backgroundColor: AppColors.primaryColor.withOpacity(0.2),
            //   child: const Icon(Icons.person,
            //       color: AppColors.primaryColor, size: 18),
            // ),
          ],
        ],
      ),
    );
  }
}
