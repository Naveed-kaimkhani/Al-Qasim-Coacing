import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class AddStudentButton extends StatefulWidget {
  final VoidCallback onTap;

  const AddStudentButton({
    super.key,
    required this.onTap,
  });

  @override
  State<AddStudentButton> createState() => _AddStudentButtonState();
}

class _AddStudentButtonState extends State<AddStudentButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: 300.ms,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF6A11CB),
                Color(0xFF2575FC),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2575FC)
                    .withOpacity(_isHovered ? 0.4 : 0.2),
                blurRadius: _isHovered ? 25 : 15,
                spreadRadius: _isHovered ? 2 : 0,
                offset: Offset(0, _isHovered ? 8 : 4),
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: 300.ms,
                width: _isHovered ? 32 : 28,
                height: _isHovered ? 32 : 28,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.add,
                  size: _isHovered ? 20 : 18,
                  color: const Color(0xFF2575FC),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Add Student",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 8),
              AnimatedOpacity(
                duration: 300.ms,
                opacity: _isHovered ? 1 : 0,
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 18,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        )
            .animate(
              onPlay: (controller) =>
                  controller.repeat(reverse: true),
            )
            .scale(
              end: const Offset(1.02, 1.02),
              duration: 1500.ms,
              curve: Curves.easeInOut,
            )
            .then()
            .scale(
              end: const Offset(1.0, 1.0),
              duration: 1500.ms,
              curve: Curves.easeInOut,
            ),
      ),
    );
  }
}
