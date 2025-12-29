import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/data/models/student_attendance.dart';

class StudentListPanel extends StatelessWidget {
  final List<StudentAttendance> students;
  final ValueChanged<StudentAttendance> onSelect;

  const StudentListPanel({required this.students, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Students",
            style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: students.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final s = students[index];
                return GestureDetector(
                  onTap: () => onSelect(s),
                  child: _StudentAttendanceCard(attendance: s)
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideX(begin: -0.1),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StudentAttendanceCard extends StatelessWidget {
  final StudentAttendance attendance;

  const _StudentAttendanceCard({required this.attendance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: attendance.student.accentColor.withOpacity(0.08),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: attendance.student.accentColor,
            child: Text(attendance.student.name[0]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(attendance.student.name,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                Text("Absent Days: ${attendance.totalAbsents}",
                    style: GoogleFonts.inter(color: Colors.red)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
