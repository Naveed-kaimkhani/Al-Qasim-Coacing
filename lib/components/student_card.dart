import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/data/models/student.dart';


// Update the StudentCard to include navigation
class StudentCard extends StatefulWidget {
  final Student student;
  final VoidCallback onTap;
  
  const StudentCard({
    super.key,
    required this.student,
    required this.onTap,
  });

  @override
  State<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
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
          duration: 200.ms,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered ? widget.student.accentColor.withOpacity(0.5) : Colors.transparent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered 
                    ? widget.student.accentColor.withOpacity(0.1) 
                    : Colors.black.withOpacity(0.03),
                blurRadius: _isHovered ? 30 : 10,
                offset: Offset(0, _isHovered ? 10 : 4),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: widget.student.accentColor.withOpacity(0.1),
                    child: Text(
                      widget.student.name[0],
                      style: TextStyle(color: widget.student.accentColor, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.student.name,
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF2C3E50)),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Roll No: ${widget.student.rollNumber}",
                          style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[500], fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[300]),
                ],
              ),
              const Spacer(),
              const Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoTag(Icons.school_outlined, widget.student.className),
                  _buildInfoTag(Icons.family_restroom_outlined, widget.student.fatherName),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTag(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.blueGrey[300]),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 13, color: Colors.blueGrey[600], fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
