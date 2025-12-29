import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

// Model for Student Score
class StudentScore {
  final String studentId;
  final String studentName;
  final String rollNumber;
  final String className;
  int obtainedMarks;
  
  StudentScore({
    required this.studentId,
    required this.studentName,
    required this.rollNumber,
    required this.className,
    required this.obtainedMarks,
  });
}

class AddTestScoresScreen extends StatefulWidget {
  const AddTestScoresScreen({super.key});

  @override
  State<AddTestScoresScreen> createState() => _AddTestScoresScreenState();
}

class _AddTestScoresScreenState extends State<AddTestScoresScreen> {
  // Test Details (Constants - Set once)
  final TextEditingController _testNameController = TextEditingController();
  final TextEditingController _chapterNameController = TextEditingController();
  final TextEditingController _chapterNumberController = TextEditingController();
  final TextEditingController _totalMarksController = TextEditingController(text: "100");
  final TextEditingController _subjectController = TextEditingController();
  
  DateTime? _testDate;
  String _selectedClass = "Grade 10";
  
  // Student Scores
  final List<StudentScore> _studentScores = [
    StudentScore(
      studentId: "1",
      studentName: "Arjun Sharma",
      rollNumber: "1001",
      className: "Grade 10",
      obtainedMarks: 0,
    ),
    StudentScore(
      studentId: "2",
      studentName: "Sara Khan",
      rollNumber: "1205",
      className: "Grade 12",
      obtainedMarks: 0,
    ),
    StudentScore(
      studentId: "3",
      studentName: "Liam Wilson",
      rollNumber: "0812",
      className: "Grade 8",
      obtainedMarks: 0,
    ),
    StudentScore(
      studentId: "4",
      studentName: "Priya Patel",
      rollNumber: "1140",
      className: "Grade 11",
      obtainedMarks: 0,
    ),
    StudentScore(
      studentId: "5",
      studentName: "Ethan Davis",
      rollNumber: "0922",
      className: "Grade 9",
      obtainedMarks: 0,
    ),
    StudentScore(
      studentId: "6",
      studentName: "Anya Taylor",
      rollNumber: "1044",
      className: "Grade 10",
      obtainedMarks: 0,
    ),
    StudentScore(
      studentId: "7",
      studentName: "Rohan Verma",
      rollNumber: "1012",
      className: "Grade 10",
      obtainedMarks: 0,
    ),
    StudentScore(
      studentId: "8",
      studentName: "Maya Singh",
      rollNumber: "1008",
      className: "Grade 10",
      obtainedMarks: 0,
    ),
  ];
  
  final List<String> _classOptions = ["Grade 8", "Grade 9", "Grade 10", "Grade 11", "Grade 12"];
  final _testDetailsFormKey = GlobalKey<FormState>();
  
  bool _testDetailsSaved = false;
  List<StudentScore> _filteredStudents = [];

  @override
  void initState() {
    super.initState();
    _filteredStudents = _studentScores;
    _testDate = DateTime.now();
  }

  void _saveTestDetails() {
    if (_testDetailsFormKey.currentState!.validate()) {
      setState(() {
        _testDetailsSaved = true;
      });
      // Filter students by selected class
      _filterStudentsByClass(_selectedClass);
    }
  }

  void _filterStudentsByClass(String className) {
    setState(() {
      _selectedClass = className;
      _filteredStudents = _studentScores.where((student) => student.className == className).toList();
    });
  }

  void _updateStudentScore(int index, String value) {
    if (value.isEmpty) {
      setState(() {
        _filteredStudents[index].obtainedMarks = 0;
      });
      return;
    }
    
    final marks = int.tryParse(value);
    if (marks != null) {
      setState(() {
        _filteredStudents[index].obtainedMarks = marks;
      });
    }
  }

  void _submitScores() {
    if (!_testDetailsSaved) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please save test details first',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    // Calculate some statistics
    final totalStudents = _filteredStudents.length;
    final studentsWithMarks = _filteredStudents.where((s) => s.obtainedMarks > 0).length;
    final totalMarks = _filteredStudents.fold(0, (sum, student) => sum + student.obtainedMarks);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          "Submit Scores",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A237E),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Test: ${_testNameController.text}",
              style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            _buildStatRow("Total Students", totalStudents.toString()),
            _buildStatRow("Students with Marks", "$studentsWithMarks/$totalStudents"),
            _buildStatRow("Total Marks", totalMarks.toString()),
            const SizedBox(height: 20),
            Text(
              "Are you sure you want to submit these scores?",
              style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700]),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Scores submitted successfully!',
                    style: GoogleFonts.inter(),
                  ),
                  backgroundColor: const Color(0xFF4CAF50),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              foregroundColor: Colors.white,
            ),
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.inter(color: Colors.grey[600])),
          Text(value, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

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
              backgroundColor: const Color(0xFF4CAF50).withOpacity(0.05),
            ),
          ),
          
          Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Panel - Test Details (Constants)
                    Expanded(
                      flex: 1,
                      child: _buildTestDetailsPanel(),
                    ),
                    
                    // Right Panel - Student Scores
                    Expanded(
                      flex: 2,
                      child: _buildStudentScoresPanel(),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Test Scores",
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A237E),
                ),
              ),
              Text(
                "Enter test details once, then add marks for each student",
                style: GoogleFonts.inter(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),
          const Spacer(),
          // Stats Chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF4CAF50).withOpacity(0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.groups_rounded, color: Color(0xFF4CAF50), size: 20),
                const SizedBox(width: 8),
                Text(
                  "${_filteredStudents.length} Students",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4CAF50),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          
          // Submit Button
          ElevatedButton.icon(
            onPressed: _submitScores,
            icon: const Icon(Icons.cloud_upload_rounded),
            label: const Text("Submit All Scores"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestDetailsPanel() {
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
              const Icon(Icons.assignment_rounded, color: Color(0xFF4CAF50)),
              const SizedBox(width: 12),
              Text(
                "Test Details",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A237E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          Form(
            key: _testDetailsFormKey,
            child: Column(
              children: [
                _buildDetailField(
                  label: "Test Name",
                  hint: "e.g., Unit Test 1",
                  controller: _testNameController,
                  icon: Icons.assignment_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter test name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildDetailField(
                        label: "Chapter Number",
                        hint: "e.g., 1",
                        controller: _chapterNumberController,
                        icon: Icons.numbers_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter chapter number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDetailField(
                        label: "Chapter Name",
                        hint: "e.g., Algebra Basics",
                        controller: _chapterNameController,
                        icon: Icons.menu_book_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter chapter name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildDetailField(
                        label: "Subject",
                        hint: "e.g., Mathematics",
                        controller: _subjectController,
                        icon: Icons.school_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter subject';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Marks",
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF2C3E50),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _totalMarksController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "100",
                              prefixIcon: const Icon(Icons.score_outlined, color: Color(0xFF4CAF50)),
                              filled: true,
                              fillColor: Colors.grey[50],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter total marks';
                              }
                              final marks = int.tryParse(value);
                              if (marks == null || marks <= 0) {
                                return 'Enter valid marks';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Date Picker
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Test Date",
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // InkWell(
                    //   onTap: () async {
                    //     final pickedDate = await showDatePicker(
                    //       context: context,
                    //       initialDate: _testDate ?? DateTime.now(),
                    //       firstDate: DateTime(2023),
                    //       lastDate: DateTime(2025),
                    //     );
                    //     if (pickedDate != null) {
                    //       setState(() {
                    //         _testDate = pickedDate;
                    //       });
                    //     }
                    //   },
                    //   borderRadius: BorderRadius.circular(12),
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    //     decoration: BoxDecoration(
                    //       color: Colors.grey[50],
                    //       borderRadius: BorderRadius.circular(12),
                    //       border: Border.all(color: Colors.grey[200]!),
                    //     ),
                    //     child: Row(
                    //       children: [
                    //         const Icon(Icons.calendar_today_rounded, color: Color(0xFF4CAF50)),
                    //         const SizedBox(width: 12),
                    //         Text(
                    //           _testDate != null
                    //               ? "${_testDate!.day}/${_testDate!.month}/${_testDate!.year}"
                    //               : "Select Date",
                    //           style: GoogleFonts.inter(
                    //             color: _testDate != null ? const Color(0xFF2C3E50) : Colors.grey[400],
                    //           ),
                    //         ),
                    //         const Spacer(),
                    //         const Icon(Icons.arrow_drop_down_rounded, color: Colors.grey),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    InkWell(
  onTap: () async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _testDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)), // 2 years from now
    );
    if (pickedDate != null) {
      setState(() {
        _testDate = pickedDate;
      });
    }
  },
  borderRadius: BorderRadius.circular(12),
  child: Container(
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.grey[50],
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey[200]!),
    ),
    child: Row(
      children: [
        const Icon(Icons.calendar_today_rounded, color: Color(0xFF4CAF50)),
        const SizedBox(width: 12),
        Text(
          _testDate != null
              ? "${_testDate!.day}/${_testDate!.month}/${_testDate!.year}"
              : "Select Date",
          style: GoogleFonts.inter(
            color: _testDate != null ? const Color(0xFF2C3E50) : Colors.grey[400],
          ),
        ),
        const Spacer(),
        const Icon(Icons.arrow_drop_down_rounded, color: Colors.grey),
      ],
    ),
  ),
),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Class Selection
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Class",
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF2C3E50),
                    ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedClass,
                          icon: const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF4CAF50)),
                          isExpanded: true,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF2C3E50),
                            fontWeight: FontWeight.w500,
                          ),
                          onChanged: (value) => _filterStudentsByClass(value!),
                          items: _classOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          
          // Save Test Details Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _saveTestDetails,
              icon: Icon(_testDetailsSaved ? Icons.check_circle_rounded : Icons.save_rounded),
              label: Text(_testDetailsSaved ? "Details Saved" : "Save Test Details"),
              style: ElevatedButton.styleFrom(
                backgroundColor: _testDetailsSaved
                    ? const Color(0xFF4CAF50).withOpacity(0.1)
                    : const Color(0xFF4CAF50),
                foregroundColor: _testDetailsSaved
                    ? const Color(0xFF4CAF50)
                    : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: _testDetailsSaved
                        ? const Color(0xFF4CAF50)
                        : Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: _testDetailsSaved,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: Colors.grey[400]),
            prefixIcon: Icon(icon, color: const Color(0xFF4CAF50)),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildStudentScoresPanel() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Panel Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
                const Icon(Icons.scoreboard_rounded, color: Color(0xFF4CAF50)),
                const SizedBox(width: 12),
                Text(
                  "Enter Scores",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A237E),
                  ),
                ),
                const Spacer(),
                if (_testDetailsSaved && _totalMarksController.text.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Total: ${_totalMarksController.text} marks",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF4CAF50),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          // Test Details Summary (Read-only)
          if (_testDetailsSaved)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
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
                        _testNameController.text,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2C3E50),
                        ),
                      ),
                      Text(
                        "Chapter ${_chapterNumberController.text}: ${_chapterNameController.text}",
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _subjectController.text,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF4CAF50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          
          const SizedBox(height: 20),
          
          // Students List with Scores
          Expanded(
            child: Container(
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
                  // Table Header
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Student",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "Roll No",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "Class",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "Marks Obtained",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(width: 40), // Space for percentage
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Students List
                  Expanded(
                    child: _filteredStudents.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                            itemCount: _filteredStudents.length,
                            itemBuilder: (context, index) {
                              final student = _filteredStudents[index];
                              return _buildStudentScoreRow(student, index);
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentScoreRow(StudentScore student, int index) {
    final totalMarks = int.tryParse(_totalMarksController.text) ?? 100;
    final percentage = totalMarks > 0
        ? (student.obtainedMarks / totalMarks * 100)
        : 0;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[100]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Student Info
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFF4CAF50).withOpacity(0.1),
                  child: Text(
                    student.studentName[0],
                    style: const TextStyle(
                      color: Color(0xFF4CAF50),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  student.studentName,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF2C3E50),
                  ),
                ),
              ],
            ),
          ),
          
          // Roll Number
          Expanded(
            child: Center(
              child: Text(
                student.rollNumber,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
          
          // Class
          Expanded(
            child: Center(
              child: Text(
                student.className,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
          
          // Marks Input
          Expanded(
            child: Center(
              child: Container(
                width: 120,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: TextField(
                  enabled: _testDetailsSaved,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2C3E50),
                  ),
                  decoration: InputDecoration(
                    hintText: "0",
                    hintStyle: GoogleFonts.inter(color: Colors.grey[400]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    suffixText: "/${_totalMarksController.text}",
                    suffixStyle: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                  onChanged: (value) => _updateStudentScore(index, value),
                ),
              ),
            ),
          ),
          
          // Percentage Display
          SizedBox(
            width: 40,
            child: Center(
              child: Text(
                totalMarks > 0 && student.obtainedMarks > 0
                    ? "${percentage.toStringAsFixed(0)}%"
                    : "-",
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: percentage >= 80
                      ? const Color(0xFF4CAF50)
                      : percentage >= 60
                          ? const Color(0xFFFF9800)
                          : const Color(0xFFFF6B6B),
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate(delay: (50 * index).ms).fadeIn().slideX(begin: 10);
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.group_off_rounded, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 20),
          Text(
            "No students in selected class",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Select a different class or add students",
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