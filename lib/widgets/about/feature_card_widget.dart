import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class FeatureCardAboutWidget extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const FeatureCardAboutWidget({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0),),
      color: AppColors.getCardColor(context),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: SizedBox(
          width: 40,
          height: 40,
          child: Image.asset(
            image,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}
