import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class EmotionChipWidget extends StatelessWidget {
  final String emotion;
  final bool isSelected;
  final VoidCallback onTap;

  const EmotionChipWidget({
    super.key,
    required this.emotion,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // <-- call the function correctly here
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor
              : AppColors.getBackgroundColor(context),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : AppColors.getFontColor(context),
            width: 1,
          ),
        ),
        child: Text(
          emotion,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.getFontColor(context),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}
