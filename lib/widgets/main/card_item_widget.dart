import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CardItem extends StatelessWidget {
  final String title;
  final String path;
  final double width;
  final double height;
  final Color color;
  final String route;
  final String description;

  const CardItem({
    super.key,
    required this.title,
    required this.path,
    required this.width,
    required this.height,
    required this.color,
    required this.route,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.getCardColor(context),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                path,
                width: width,
                height: height,
              ),
            ),
            // const SizedBox(height: 12),
            Text.rich(
              TextSpan(
                text: 'Sere',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.getPrimaryColor(context),
                  fontFamily: 'Montserrat',
                ),
                children: [
                  TextSpan(
                    text: title.substring(
                      4,
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.getFontColor(context),
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.getFontColor(context),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
