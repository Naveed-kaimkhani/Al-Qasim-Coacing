
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math';
class AnimatedBackground extends StatelessWidget {
  final Random _random = Random();

  AnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main Gradient Background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1E88E5),
                const Color(0xFF4CAF50),
                const Color(0xFFFFC107),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),

        // Animated Circles/Shapes
        ...List.generate(15, (index) {
          final size = 50 + _random.nextDouble() * 100;
          return Positioned(
            left: _random.nextDouble() * MediaQuery.of(context).size.width,
            top: _random.nextDouble() * MediaQuery.of(context).size.height,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(_random.nextDouble() * 0.1),
              ),
            ).animate(
              delay: (index * 100).ms,
            )
            .fadeIn(duration: 2.seconds)
            .scale(begin: Offset(0, 0), end: Offset(1, 1), curve: Curves.easeOut),
          );
        }),

        // Educational Icons in Background
        Positioned(
          right: 100,
          top: 100,
          child: Icon(
            Icons.school_rounded,
            size: 120,
            color: Colors.white.withOpacity(0.1),
          ).animate().rotate(duration: 20.seconds),
        ),
        Positioned(
          left: 100,
          bottom: 100,
          child: Icon(
            Icons.library_books_rounded,
            size: 150,
            color: Colors.white.withOpacity(0.08),
          ),
        ),
      ],
    );
  }
}


