


import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A237E), Color(0xFF3949AB), Color(0xFF1565C0)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -150,
            left: -150,
            child: _FloatingOrb(color: Colors.white.withOpacity(0.05), size: 500),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: _FloatingOrb(color: Colors.blue.withOpacity(0.1), size: 600),
          ),
          Positioned(
            top: 100,
            right: 100,
            child: _FloatingOrb(color: Colors.white.withOpacity(0.03), size: 300),
          ),
        ],
      ),
    );
  }
}



class _FloatingOrb extends StatelessWidget {
  final Color color;
  final double size;
  const _FloatingOrb({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    ).animate(onPlay: (c) => c.repeat(reverse: true))
     .moveX(begin: -30, end: 30, duration: NumDurationExtensions(8).seconds, curve: Curves.easeInOut)
     .moveY(begin: -20, end: 20, duration: NumDurationExtensions(6).seconds, curve: Curves.easeInOut);
  }
}