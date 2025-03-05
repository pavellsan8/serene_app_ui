import 'package:flutter/material.dart';
import 'package:serene_app/utils/colors.dart';

import 'meter_painter_widget.dart';

class FeelingMeterWidget extends StatelessWidget {
  final int selectedValue;
  final Function(int) onValueChanged;

  const FeelingMeterWidget({
    super.key,
    required this.selectedValue,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size(300, 150),
          painter: MeterPainter(value: selectedValue, maxValue: 5),
        ),
        Column(
          children: [
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 1; i <= 5; i++)
                  GestureDetector(
                    onTap: () {
                      onValueChanged(i);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: selectedValue == i
                            ? AppColors.primaryColor.withOpacity(0.2)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
