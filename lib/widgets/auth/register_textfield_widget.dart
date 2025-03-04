import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CustomLabel extends StatelessWidget {
  final String text;
  const CustomLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.fontColor,
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            border: UnderlineInputBorder(
              borderRadius:
                  BorderRadius.circular(8), 
              borderSide:
                  const BorderSide(color: Colors.grey), 
            ),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.buttonColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.buttonColor, width: 2),
            ),
            errorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            errorText: validator != null ? validator!(controller.text) : null,
          ),
        ),
      ],
    );
  }
}
