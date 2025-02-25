import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import 'dart:math';

class MeterPainter extends CustomPainter {
  final int value;
  final int maxValue;

  MeterPainter({required this.value, required this.maxValue});

  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 30.0;
    final double radius = size.width / 2 - strokeWidth; // Radius lingkaran
    final Offset center = Offset(size.width / 2, size.height);

    // 1. Gambar background meter (garis abu-abu)
    final Paint paintBackground = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round; // Ujung garis lebih halus

    final Rect arcRect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(
      arcRect,
      pi, // Mulai dari kiri (180 derajat)
      pi, // Setengah lingkaran (180 derajat)
      false,
      paintBackground,
    );

    // 2. Gambar nilai meter (garis warna utama)
    final Paint paintValue = Paint()
      ..color = AppColors.buttonColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    double valueAngle = (value / maxValue) * pi; // Sesuaikan panjang berdasarkan nilai
    canvas.drawArc(
      arcRect,
      pi,
      valueAngle,
      false,
      paintValue,
    );

    // 3. Gambar angka pada meter
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    for (int i = 1; i <= maxValue; i++) {
      double angle = pi + (i - 1) * (pi / (maxValue - 1)); // Posisi angka secara simetris
      double x = center.dx + radius * cos(angle);
      double y = center.dy + radius * sin(angle);

      final textSpan = TextSpan(text: "$i", style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - textPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}