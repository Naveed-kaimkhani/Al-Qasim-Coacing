import 'dart:ui';

class Student {
  final String? id;
  final String name;
  final String fatherName;
  final String className;
  final String rollNumber;
  final Color accentColor;
  final List<DateTime>? absentDates;
  final DateTime? joinDate;

  Student({
     this.id,
    required this.name,
    required this.fatherName,
    required this.className,
    required this.rollNumber,
    required this.accentColor,
     this.absentDates,
    this.joinDate,
  });

  int get totalAbsentDays => absentDates?.length ?? 0;
}