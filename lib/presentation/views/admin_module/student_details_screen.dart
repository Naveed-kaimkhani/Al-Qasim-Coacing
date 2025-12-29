import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/data/models/student.dart';
import 'package:qr_code_scanner/presentation/views/admin_module/FeeManagementScreen.dart';
import 'package:qr_code_scanner/presentation/views/admin_module/attendance_management_screen.dart';
import 'package:qr_code_scanner/presentation/views/admin_module/student_test_resultsScreen.dart';
// Student Details Screen
class StudentDetailsScreen extends StatelessWidget {
  final Student student;
  
  const StudentDetailsScreen({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: Stack(
        children: [
          // Background Decoration
          Positioned(
            top: -100,
            right: -100,
            child: CircleAvatar(
              radius: 200,
              backgroundColor: student.accentColor.withOpacity(0.05),
            ),
          ),
          
          Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: _buildStudentManagementOptions(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded, size: 24),
            color: const Color(0xFF1A237E),
          ),
          const SizedBox(width: 20),
          CircleAvatar(
            radius: 30,
            backgroundColor: student.accentColor.withOpacity(0.1),
            child: Text(
              student.name[0],
              style: TextStyle(
                color: student.accentColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                student.name,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A237E),
                ),
              ),
              Text(
                "${student.className} • Roll No: ${student.rollNumber}",
                style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: student.accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: student.accentColor.withOpacity(0.2)),
            ),
            child: Text(
              student.className,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: student.accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
Widget _buildStudentManagementOptions() {
  return Padding(
    padding: const EdgeInsets.all(30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Student Management",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Select an option to manage ${student.name}'s records",
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 30),
        
        Expanded(
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Changed from 2 to 3 for more compact layout
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.2, // Changed from 1.6 to 1.2 for smaller cards
            ),
            children: [
              // Attendance Management
              _buildManagementCard(
                icon: Icons.calendar_month_rounded,
                title: "Attendance",
                subtitle: "View & manage attendance",
                color: const Color(0xFF4361EE),
                onTap: () {
                  // Navigate to Attendance Management Screen
              Get.to(() => AttendanceManagementScreen());
                  print("Navigate to ${student.name}'s Attendance");
                },
              ),
              
              // Fee Management
              _buildManagementCard(
                icon: Icons.monetization_on_rounded,
                title: "Fee Management",
                subtitle: "View & update fee payments",
                color: const Color(0xFF7209B7),
                onTap: () {
                  // Navigate to Fee Management Screen

              Get.to(() => StudentFeeScreen(
                studentName: "Naveed",
                className: "10th Grade",
                rollNumber: "23",
              ));
                  print("Navigate to ${student.name}'s Fee Management");
                },
              ),
              
              // Test Results
              _buildManagementCard(
                icon: Icons.assignment_rounded,
                title: "Test Results",
                subtitle: "View test scores",
                color: const Color(0xFF4CAF50),
                onTap: () {
                  // Navigate to Test Results Screen
                  Get.to(() => StudentTestResultsScreen(
                    studentName: "Naveed",
                    className: "10th Grade",
                    rollNumber: "23",
                  ));
                  print("Navigate to ${student.name}'s Test Results");
                },
              ),
              
           
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildManagementCard({
  required IconData icon,
  required String title,
  required String subtitle,
  required Color color,
  required VoidCallback onTap,
}) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 300.ms,
        padding: const EdgeInsets.all(20), // Reduced from 24
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20), // Reduced from 24
          border: Border.all(color: color.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 15, // Reduced from 20
              offset: const Offset(0, 3), // Reduced from 4
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50, // Reduced from 60
              height: 50, // Reduced from 60
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14), // Reduced from 16
              ),
              child: Icon(icon, size: 28, color: color), // Reduced from 32
            ),
            const SizedBox(height: 16), // Reduced from 20
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16, // Reduced from 18
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 6), // Reduced from 8
            Text(
              subtitle,
              style: GoogleFonts.inter(
                fontSize: 12, // Reduced from 13
                color: Colors.grey[600],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  "View",
                  style: GoogleFonts.inter(
                    fontSize: 12, // Reduced from 13
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                const SizedBox(width: 6), // Reduced from 8
                Icon(Icons.arrow_forward_rounded, size: 14, color: color), // Reduced from 16
              ],
            ),
          ],
        ),
      ).animate().fadeIn().slideY(begin: 10), // Reduced from 20
    ),
  );
}

}
