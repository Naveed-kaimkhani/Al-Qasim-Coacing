import 'package:flutter/material.dart';
import 'package:qr_code_scanner/core/theme/app_colors.dart';
import 'package:qr_code_scanner/data/models/student_score.dart';

class StudentScoreRow extends StatelessWidget {
  final StudentScore student;
  final int totalMarks;
  final bool enabled;
  final ValueChanged<String> onChanged;

  const StudentScoreRow({
    super.key,
    required this.student,
    required this.totalMarks,
    required this.enabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final percentage =
        totalMarks > 0 ? (student.obtainedMarks / totalMarks) * 100 : 0;

    return Row(
      children: [
        Expanded(child: Text(student.studentName)),
        Expanded(child: Text(student.rollNumber)),
        Expanded(
          child: TextField(
            enabled: enabled,
            onChanged: onChanged,
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          percentage > 0 ? "${percentage.toInt()}%" : "-",
          style: TextStyle(
            color: percentage >= 80
                ? AppColors.success
                : percentage >= 60
                    ? AppColors.warning
                    : AppColors.danger,
          ),
        ),
      ],
    );
  }
}
