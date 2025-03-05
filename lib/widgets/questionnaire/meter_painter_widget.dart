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
      ..strokeCap = StrokeCap.round;

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
      ..color = AppColors.primaryColor
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

    // 3. Gambar angka pada meter dengan warna yang sesuai
    for (int i = 1; i <= maxValue; i++) {
      double angle = pi + (i - 1) * (pi / (maxValue - 1)); // Posisi angka secara simetris
      double x = center.dx + radius * cos(angle);
      double y = center.dy + radius * sin(angle);

      // Tentukan warna teks berdasarkan posisi angka (apakah dalam area biru)
      Color textColor = i <= value ? Colors.white : Colors.black;
      final textStyle = TextStyle(
        color: textColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );

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

class InteractiveMeter extends StatefulWidget {
  final int initialValue;
  final int maxValue;
  final ValueChanged<int> onValueChanged;

  const InteractiveMeter({
    Key? key,
    required this.initialValue, 
    required this.maxValue,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  State<InteractiveMeter> createState() => _InteractiveMeterState();
}

class _InteractiveMeterState extends State<InteractiveMeter> {
  late int _currentValue;
  
  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  void _handleTapDown(TapDownDetails details) {
    _checkTapOnNumber(details.localPosition);
  }

  void _checkTapOnNumber(Offset tapPosition) {
    // Mendapatkan ukuran widget
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    
    // Menghitung posisi pusat meter
    final Offset center = Offset(size.width / 2, size.height);
    
    // Konstanta untuk meter
    const double strokeWidth = 30.0;
    final double radius = size.width / 2 - strokeWidth;
    
    // Ukuran area ketuk untuk angka (buffer)
    const double hitTestRadius = 20.0;
    
    // Periksa apakah klik mendekati salah satu angka pada meter
    for (int i = 1; i <= widget.maxValue; i++) {
      double angle = pi + (i - 1) * (pi / (widget.maxValue - 1));
      double x = center.dx + radius * cos(angle);
      double y = center.dy + radius * sin(angle);
      
      // Hitung jarak dari posisi klik ke posisi angka
      double dx = tapPosition.dx - x;
      double dy = tapPosition.dy - y;
      double distance = sqrt(dx * dx + dy * dy);
      
      // Jika klik cukup dekat dengan angka, atur nilai meter
      if (distance <= hitTestRadius) {
        if (_currentValue != i) {
          setState(() {
            _currentValue = i;
          });
          widget.onValueChanged(i);
        }
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      child: CustomPaint(
        painter: MeterPainter(
          value: _currentValue,
          maxValue: widget.maxValue,
        ),
        size: Size(300, 150), // Sesuaikan ukuran meter sesuai kebutuhan
      ),
    );
  }
}