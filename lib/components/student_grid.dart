import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_code_scanner/components/student_card.dart';
import 'package:qr_code_scanner/data/models/student.dart';

class StudentGrid extends StatelessWidget {
  final List<Student> students;

  const StudentGrid({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(40),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        mainAxisExtent: 200,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
      ),
      itemCount: students.length,
      itemBuilder: (_, index) {
        return StudentCard(student: students[index],onTap: () {
          
        },)
            .animate(delay: (100 * index).ms)
            .fadeIn()
            .moveY(begin: 20);
      },
    );
  }
}
