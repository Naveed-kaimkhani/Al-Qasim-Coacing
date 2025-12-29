import 'package:flutter/material.dart';
import 'package:qr_code_scanner/data/models/student_score.dart';
class StudentScoresPanel extends StatelessWidget {
  final List<StudentScore> students;
  final int totalMarks;
  final bool enabled;

  const StudentScoresPanel({
    super.key,
    required this.students,
    required this.totalMarks,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Student Scores",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView.separated(
                itemCount: students.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final student = students[index];

                  return Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${student.rollNumber} • ${student.studentName}",
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: TextFormField(
                          enabled: enabled,
                          initialValue:
                              student.obtainedMarks.toString(),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "0/$totalMarks",
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (value) {
                            student.obtainedMarks =
                                int.tryParse(value) ?? 0;
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
