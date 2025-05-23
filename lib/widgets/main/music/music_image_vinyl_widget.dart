import 'package:flutter/material.dart';

class RotatingDisc extends StatefulWidget {
  final String imageUrl;
  final double size;
  final bool autoPlay;

  const RotatingDisc({
    Key? key,
    required this.imageUrl,
    this.size = 300,
    this.autoPlay = true,
  }) : super(key: key);

  @override
  State<RotatingDisc> createState() => _RotatingDiscState();
}

class _RotatingDiscState extends State<RotatingDisc>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    if (widget.autoPlay) {
      _controller.repeat();
    } else {
      _isPlaying = false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Vinyl record base (black circle)
          Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((0.3 * 255).toInt()),
                  blurRadius: 15,
                  spreadRadius: 2,
                )
              ],
            ),
          ),

          // Vinyl grooves
          Container(
            width: widget.size * 0.95,
            height: widget.size * 0.95,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.grey.shade800,
                  Colors.black.withAlpha((0.8 * 255).toInt()),
                ],
                stops: const [0.6, 1.0],
              ),
            ),
            child: CustomPaint(
              painter: VinylGroovesPainter(),
            ),
          ),

          // Album cover rotating
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * 3.14159, // Full rotation
                child: child,
              );
            },
            child: Container(
              width: widget.size * 0.75,
              height: widget.size * 0.75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.2 * 255).toInt()),
                    blurRadius: 10,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: ClipOval(
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.music_note,
                      size: widget.size * 0.3,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Center hole
          Container(
            width: widget.size * 0.08,
            height: widget.size * 0.08,
            decoration: BoxDecoration(
              color: Colors.black.withAlpha((0.8 * 255).toInt()),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey.withAlpha((0.5 * 255).toInt()),
                width: 1,
              ),
            ),
          ),

          // Play/Pause indicator
          AnimatedOpacity(
            opacity: _isPlaying ? 0.0 : 0.8,
            duration: const Duration(milliseconds: 300),
            child: Container(
              width: widget.size * 0.2,
              height: widget.size * 0.2,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha((0.7 * 255).toInt()),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: widget.size * 0.12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter untuk membuat garis-garis vinyl
class VinylGroovesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = Colors.grey.withAlpha((0.3 * 255).toInt())
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // Membuat lingkaran konsentris untuk efek groove vinyl
    double maxRadius = size.width / 2;
    for (double i = maxRadius * 0.2; i < maxRadius * 0.95; i += 3) {
      canvas.drawCircle(center, i, paint);
    }

    // Membuat beberapa garis groove yang lebih tebal
    paint.strokeWidth = 1.0;
    paint.color = Colors.grey.withAlpha((0.5 * 255).toInt());
    for (double i = maxRadius * 0.3;
        i < maxRadius * 0.95;
        i += maxRadius * 0.15) {
      canvas.drawCircle(center, i, paint);
    }
  }

  @override
  bool shouldRepaint(VinylGroovesPainter oldDelegate) => false;
}
