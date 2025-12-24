import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedButton extends StatelessWidget {
  final Widget child;
  final Duration delay;

  const AnimatedButton({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return child.animate(delay: delay).fadeIn().scale(
              begin: const Offset(0.8, 0.8),  // Scale both X and Y
          end: const Offset(1.0, 1.0),
          duration: 600.ms,
          curve: Curves.elasticOut,
        );
  }
}