import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serene_app/utils/colors.dart';

import '../../../widgets/questionnaire/continue_btn_widget.dart';
import '../../../widgets/questionnaire/feeling_meter_widget.dart';
import '../../../viewmodels/questionnaire/feeling_page_viewmodel.dart';

class FeelingPage extends StatelessWidget {
  final VoidCallback onContinue;

  const FeelingPage({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Consumer<FeelingViewModel>(
      builder: (context, viewModel, child) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "We'd love to know how you're doing right now. Please tell us from 1 to 5 how do you feel right now.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 48),
              Text(
                viewModel.selectedValue.toString(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              FeelingMeterWidget(
                selectedValue: viewModel.selectedValue,
                onValueChanged: viewModel.updateFeelingValue,
              ),
              const SizedBox(height: 64),
              const Text(
                "Well done! From this meter you can know whether it is good or bad, but with our help you can improve it even better",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              ContinueButton(onPressed: onContinue),
            ],
          ),
        );
      },
    );
  }
}
