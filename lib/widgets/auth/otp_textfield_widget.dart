import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../utils/colors.dart';

class CustomOtpField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onCompleted;

  const CustomOtpField({
    super.key,
    required this.controller,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      controller: controller,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        fieldHeight: 50,
        fieldWidth: 50,
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        selectedFillColor: Colors.white,
        activeColor: AppColors.primaryColor,
        inactiveColor: Colors.grey.shade300,
        selectedColor: AppColors.primaryColor,
      ),
      cursorColor: AppColors.primaryColor,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      boxShadows: [
        BoxShadow(
          offset: const Offset(0, 1),
          color: Colors.black.withOpacity(0.05),
          blurRadius: 2,
        )
      ], onChanged: (String value) {},
    );
  }
}