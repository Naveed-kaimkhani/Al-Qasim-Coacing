



import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/presentation/views/school_management_app.dart';
import 'package:qr_code_scanner/presentation/views/student/studen_list.dart';
import 'package:qr_code_scanner/presentation/views/student/student_details_screen.dart';
import 'package:qr_code_scanner/presentation/views/student/attendance_management_screen.dart' ;
import 'package:qr_code_scanner/presentation/views/student/student_registration_screen.dart';

void main() => runApp(const StudentRegistrationApp());

class StudentRegistrationApp extends StatelessWidget {
  const StudentRegistrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EduManage Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF1E88E5),
    brightness: Brightness.light,
  ),
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    displayLarge: GoogleFonts.poppins(
      fontSize: 48,
      fontWeight: FontWeight.w800,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 36,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 28,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  ),
),
      // home:  StudentDetailsScreen(
      //   student: Student(
      //     id: '1',
      //     name: 'John Doe',
      //     className: '10th Grade',
      //     rollNumber: '23',
      //     absentDates: [],
      //     fatherName: 'Mr. Doe',
      //     accentColor: Color(0xFF1E88E5),
      //   ),
      // ),
    home: StudentListScreen(),
    );
  }
}

