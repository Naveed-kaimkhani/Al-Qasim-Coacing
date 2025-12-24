import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedFormField extends StatelessWidget {
  final Widget child;
  final Duration delay;

  const AnimatedFormField({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return child.animate(delay: delay).fadeIn().slideX(
          begin: -0.5,
          end: 0,
          duration: 500.ms,
          curve: Curves.easeOut,
        );
  }
}