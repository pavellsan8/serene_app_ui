import 'dart:math';

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
                color: isUser
                    ? AppColors.primaryColor
                    : AppColors.getChatbotBubbleColor(context),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color:
                      isUser ? Colors.white : AppColors.getFontColor(context),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat',
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

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => TypingIndicatorState();
}

class TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            final delay = index * 0.4;
            final position =
                sin((_controller.value * 2 * pi) + delay) * 0.5 + 0.5;
            return Container(
              width: 6,
              height: 6 + (position * 4),
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withAlpha(
                  (0.7 + (position * 0.3) * 255).toInt(),
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        );
      },
    );
  }
}
