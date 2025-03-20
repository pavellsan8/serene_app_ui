import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class EmotionChipWidget extends StatelessWidget {
  final String label;

  const EmotionChipWidget({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Colors.white,
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontFamily: 'Montserrat',
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: AppColors.fontBlueColor,
        ),
      ),
    );
  }
}
