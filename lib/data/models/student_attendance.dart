import 'package:qr_code_scanner/data/models/student.dart';
class StudentAttendance {
  final Student student;
  final Set<DateTime> absentDays;

  StudentAttendance({
    required this.student,
    required this.absentDays,
  });

  int get totalAbsents => absentDays.length;
}
