import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/data/models/student.dart';
import 'package:table_calendar/table_calendar.dart';


// Model for Student Data


// Attendance Record Screen
class AttendanceManagementScreen extends StatefulWidget {
  const AttendanceManagementScreen({super.key});

  @override
  State<AttendanceManagementScreen> createState() => _AttendanceManagementScreenState();
}

class _AttendanceManagementScreenState extends State<AttendanceManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Student? _selectedStudent;
  
  // Mock Data with Absent Dates
  final List<Student> _allStudents = [
    Student(
      id: "1",
      name: "Arjun Sharma",
      fatherName: "Rajesh Sharma",
      className: "Grade 10",
      rollNumber: "1001",
      accentColor: const Color(0xFF4361EE),
      absentDates: [
        DateTime.now().subtract(const Duration(days: 2)),
        DateTime.now().subtract(const Duration(days: 5)),
        DateTime.now().subtract(const Duration(days: 10)),
      ],
      joinDate: DateTime(2024, 1, 10),
    ),
    Student(
      id: "2",
      name: "Sara Khan",
      fatherName: "Ahmed Khan",
      className: "Grade 12",
      rollNumber: "1205",
      accentColor: const Color(0xFF7209B7),
      absentDates: [
        DateTime.now().subtract(const Duration(days: 1)),
        DateTime.now().subtract(const Duration(days: 4)),
      ],
      joinDate: DateTime(2024, 1, 15),
    ),
    Student(
      id: "3",
      name: "Liam Wilson",
      fatherName: "Robert Wilson",
      className: "Grade 8",
      rollNumber: "0812",
      accentColor: const Color(0xFFF8961E),
      absentDates: [
        DateTime.now().subtract(const Duration(days: 3)),
        DateTime.now().subtract(const Duration(days: 7)),
        DateTime.now().subtract(const Duration(days: 8)),
        DateTime.now().subtract(const Duration(days: 12)),
      ],
      joinDate: DateTime(2024, 1, 20),
    ),
  ];

  List<Student> _filteredStudents = [];

  @override
  void initState() {
    super.initState();
    _filteredStudents = _allStudents;
    _selectedStudent = _filteredStudents.first;
    _selectedDay = DateTime.now();
  }

  void _filterList(String query) {
    setState(() {
      _filteredStudents = _allStudents
          .where((s) => s.name.toLowerCase().contains(query.toLowerCase()) || 
                        s.rollNumber.contains(query))
          .toList();
      if (_filteredStudents.isNotEmpty) {
        _selectedStudent = _filteredStudents.first;
      }
    });
  }

  void _markAttendance(DateTime date, bool present) {
    setState(() {
      if (_selectedStudent != null) {
        if (!present) {
          // Mark as absent
          if (!_selectedStudent!.absentDates!.any((d) => 
              d.year == date.year && d.month == date.month && d.day == date.day)) {
            _selectedStudent!.absentDates!.add(date);
          }
        } else {
          // Mark as present (remove from absent list)
          _selectedStudent!.absentDates!.removeWhere((d) => 
              d.year == date.year && d.month == date.month && d.day == date.day);
        }
      }
    });
  }

  void _showAddStudentModal() {
    // showModalBottomSheet(
    //   context: context,
    //   isScrollControlled: true,
    //   backgroundColor: Colors.transparent,
    //   builder: (context) => const AddStudentModal(),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddStudentModal,
        backgroundColor: const Color(0xFF4361EE),
        foregroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: const Icon(Icons.person_add_rounded),
        label: Text(
          "Add Student",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ).animate().slideUp(duration: 500.ms, delay: 200.ms),
      body: Stack(
        children: [
          // Background Decoration
          Positioned(
            top: -100,
            right: -100,
            child: CircleAvatar(
              radius: 200,
              backgroundColor: const Color(0xFF4361EE).withOpacity(0.05),
            ),
          ),
          Positioned(
            bottom: -150,
            left: -100,
            child: CircleAvatar(
              radius: 200,
              backgroundColor: const Color(0xFF7209B7).withOpacity(0.05),
            ),
          ),
          
          Column(
            children: [
              // _buildHeader(),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Panel - Student List
                    Expanded(
                      flex: 1,
                      child: _buildStudentListPanel(),
                    ),
                    
                    // Right Panel - Calendar & Details
                    Expanded(
                      flex: 2,
                      child: _buildAttendancePanel(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Attendance Management",
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A237E),
                ),
              ),
              Text(
                "Track and manage student attendance records",
                style: GoogleFonts.inter(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),
          const Spacer(),
          // Search Bar
          Container(
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[200]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _filterList,
              decoration: InputDecoration(
                hintText: "Search students...",
                hintStyle: GoogleFonts.inter(color: Colors.grey[400]),
                prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF4361EE)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),
          ),
          const SizedBox(width: 20),
          // Stats Chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF4361EE).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF4361EE).withOpacity(0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.groups_rounded, color: Color(0xFF4361EE), size: 20),
                const SizedBox(width: 8),
                Text(
                  "${_allStudents.length} Students",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4361EE),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentListPanel() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.list_alt_rounded, color: Color(0xFF4361EE)),
              const SizedBox(width: 12),
              Text(
                "Student List",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A237E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _filteredStudents.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    itemCount: _filteredStudents.length,
                    separatorBuilder: (context, index) => const Divider(height: 12),
                    itemBuilder: (context, index) {
                      final student = _filteredStudents[index];
                      return _buildStudentListItem(student, index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentListItem(Student student, int index) {
    final isSelected = _selectedStudent?.id == student.id;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedStudent = student;
          _selectedDay = DateTime.now();
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: 300.ms,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? student.accentColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? student.accentColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: student.accentColor.withOpacity(0.1),
              child: Text(
                student.name[0],
                style: TextStyle(
                  color: student.accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2C3E50),
                    ),
                  ),
                  Text(
                    student.className,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            // Absent Days Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: student.totalAbsentDays > 5
                    ? const Color(0xFFFF6B6B).withOpacity(0.1)
                    : const Color(0xFF4CAF50).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    student.totalAbsentDays > 5
                        ? Icons.warning_amber_rounded
                        : Icons.check_circle_rounded,
                    size: 12,
                    color: student.totalAbsentDays > 5
                        ? const Color(0xFFFF6B6B)
                        : const Color(0xFF4CAF50),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "${student.totalAbsentDays} absences",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: student.totalAbsentDays > 5
                          ? const Color(0xFFFF6B6B)
                          : const Color(0xFF4CAF50),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ).animate(delay: (50 * index).ms).fadeIn().slideX(begin: -10),
    );
  }

  Widget _buildAttendancePanel() {
    if (_selectedStudent == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_search_rounded, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 20),
            Text(
              "Select a student to view attendance",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Student Summary Card
          _buildStudentSummaryCard(),
          const SizedBox(height: 20),
          // Calendar Section
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Calendar View
                Expanded(
                  flex: 2,
                  child: _buildCalendarView(),
                ),
                const SizedBox(width: 20),
                // Attendance Actions
                Expanded(
                  flex: 1,
                  child: _buildAttendanceActions(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
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
          CircleAvatar(
            radius: 40,
            backgroundColor: _selectedStudent!.accentColor.withOpacity(0.1),
            child: Text(
              _selectedStudent!.name[0],
              style: TextStyle(
                color: _selectedStudent!.accentColor,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedStudent!.name,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A237E),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildInfoChip(Icons.badge_rounded, _selectedStudent!.rollNumber),
                    const SizedBox(width: 12),
                    _buildInfoChip(Icons.school_rounded, _selectedStudent!.className),
                    const SizedBox(width: 12),
                    _buildInfoChip(Icons.family_restroom_rounded, _selectedStudent!.fatherName),
                  ],
                ),
              ],
            ),
          ),
          // Absent Days Counter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF4361EE),
                  const Color(0xFF3A56E0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4361EE).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  "Total Absences",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _selectedStudent!.totalAbsentDays.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "days",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: const Color(0xFF4361EE)),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2C3E50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarView() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_month_rounded, color: Color(0xFF4361EE)),
              const SizedBox(width: 12),
              Text(
                "Attendance Calendar",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A237E),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  // Legend
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B6B),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Absent",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Present",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: TableCalendar(
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2028, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              // onDaySelected: (selectedDay, focusedDay) {
              //   setState(() {
              //     _selectedDay = selectedDay;
              //     _focusedDay = focusedDay;
              //   });
              // },
              // onPageChanged: (focusedDay) {
              //   _focusedDay = focusedDay;
              // },
            onPageChanged: (focusedDay) {
              final firstDay = DateTime.utc(2024, 1, 1);
              final lastDay = DateTime.utc(2024, 12, 31);
              
              if (focusedDay.isAfter(lastDay)) {
                setState(() {
                  _focusedDay = lastDay;
                });
              } else if (focusedDay.isBefore(firstDay)) {
                setState(() {
                  _focusedDay = firstDay;
                });
              } else {
                setState(() {
                  _focusedDay = focusedDay;
                });
              }
            },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: const Color(0xFF4361EE).withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF4361EE), width: 2),
                ),
                selectedDecoration: const BoxDecoration(
                  color: Color(0xFF4361EE),
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: TextStyle(color: Colors.grey[700]),
                defaultTextStyle: GoogleFonts.inter(fontWeight: FontWeight.w500),
                outsideDaysVisible: false,
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A237E),
                ),
                leftChevronIcon: const Icon(Icons.chevron_left, color: Color(0xFF4361EE)),
                rightChevronIcon: const Icon(Icons.chevron_right, color: Color(0xFF4361EE)),
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  final isAbsent = _selectedStudent!.absentDates!.any((date) =>
                      day.year == date.year &&
                      day.month == date.month &&
                      day.day == date.day);
                  
                  if (isAbsent) {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B6B).withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFFF6B6B), width: 2),
                      ),
                      child: Center(
                        child: Text(
                          day.day.toString(),
                          style: GoogleFonts.inter(
                            color: const Color(0xFFFF6B6B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }
                  return null;
                },
                todayBuilder: (context, day, focusedDay) {
                  final isAbsent = _selectedStudent!.absentDates!.any((date) =>
                      day.year == date.year &&
                      day.month == date.month &&
                      day.day == date.day);
                  
                  if (isAbsent) {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B6B),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          day.day.toString(),
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceActions() {
    final isAbsentToday = _selectedStudent!.absentDates!.any((date) =>
        date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Attendance",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A237E),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            DateFormat('EEEE, MMMM d').format(DateTime.now()),
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),
          
          // Attendance Status
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isAbsentToday
                  ? const Color(0xFFFF6B6B).withOpacity(0.1)
                  : const Color(0xFF4CAF50).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isAbsentToday
                    ? const Color(0xFFFF6B6B).withOpacity(0.3)
                    : const Color(0xFF4CAF50).withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isAbsentToday ? Icons.warning_amber_rounded : Icons.check_circle_rounded,
                  color: isAbsentToday ? const Color(0xFFFF6B6B) : const Color(0xFF4CAF50),
                  size: 32,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isAbsentToday ? "Absent Today" : "Present Today",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isAbsentToday
                              ? const Color(0xFFFF6B6B)
                              : const Color(0xFF4CAF50),
                        ),
                      ),
                      Text(
                        isAbsentToday
                            ? "Marked as absent for today"
                            : "Student is present today",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          Text(
            "Quick Actions",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A237E),
            ),
          ),
          const SizedBox(height: 16),
          
          // Action Buttons
          Column(
            children: [
              ElevatedButton.icon(
                onPressed: () => _markAttendance(DateTime.now(), true),
                icon: const Icon(Icons.check_circle_outline_rounded),
                label: const Text("Mark Present"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
              ).animate().slideX(begin: 20).fadeIn(),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => _markAttendance(DateTime.now(), false),
                icon: const Icon(Icons.highlight_off_rounded),
                label: const Text("Mark Absent"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFFF6B6B),
                  side: const BorderSide(color: Color(0xFFFF6B6B)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ).animate(delay: 100.ms).slideX(begin: 20).fadeIn(),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {
                  // Show detailed attendance report
                },
                icon: const Icon(Icons.bar_chart_rounded),
                label: const Text("View Report"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF4361EE),
                  side: const BorderSide(color: Color(0xFF4361EE)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ).animate(delay: 200.ms).slideX(begin: 20).fadeIn(),
            ],
          ),
          
          const Spacer(),
          // Monthly Stats
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FB),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "This Month",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      "${DateTime.now().month}/${DateTime.now().year}",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A237E),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Absent Days",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      _selectedStudent!.absentDates
                          !.where((date) =>
                              date.month == DateTime.now().month &&
                              date.year == DateTime.now().year)
                          .length
                          .toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFF6B6B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_search_rounded, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 20),
          Text(
            "No students found",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Try adjusting your search or add a new student",
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
