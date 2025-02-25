import 'package:flutter/material.dart';
import 'package:serene_app/utils/colors.dart';

import '../../../widgets/questionnaire/continue_btn_widget.dart';
import '../../../widgets/questionnaire/feeling_meter_widget.dart';

class FeelingPage extends StatelessWidget {
  final int selectedValue;
  final Function(int) onValueChanged;
  final VoidCallback onContinue;

  const FeelingPage({
    super.key,
    required this.selectedValue,
    required this.onValueChanged,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "We'd love to know how you're doing right now. Please tell us from 1 to 5 how do you feel right now.",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 48),
          Text(
            selectedValue.toString(),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.buttonColor,
            ),
          ),
          const SizedBox(height: 16),
          FeelingMeterWidget(
            selectedValue: selectedValue,
            onValueChanged: onValueChanged,
          ),
          const SizedBox(height: 64),
          const Text(
            "Well done! From this meter you can know whether it is good or bad, but with our help you can improve it even better",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          ContinueButton(onPressed: onContinue),
        ],
      ),
    );
  }
}
