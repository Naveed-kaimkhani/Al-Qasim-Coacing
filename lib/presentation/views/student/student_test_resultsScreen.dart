import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

// Model for Test Result
class TestResult {
  final String id;
  final String testName;
  final String chapterName;
  final int chapterNumber;
  final String subject;
  final DateTime testDate;
  final int totalMarks;
  final int obtainedMarks;
  final double percentage;
  final String grade;
  final Color gradeColor;

  TestResult({
    required this.id,
    required this.testName,
    required this.chapterName,
    required this.chapterNumber,
    required this.subject,
    required this.testDate,
    required this.totalMarks,
    required this.obtainedMarks,
    required this.percentage,
    required this.grade,
    required this.gradeColor,
  });
}

class StudentTestResultsScreen extends StatefulWidget {
  final String studentName;
  final String className;
  final String rollNumber;
  
  const StudentTestResultsScreen({
    super.key,
    required this.studentName,
    required this.className,
    required this.rollNumber,
  });

  @override
  State<StudentTestResultsScreen> createState() => _StudentTestResultsScreenState();
}

class _StudentTestResultsScreenState extends State<StudentTestResultsScreen> {
  int _currentFilter = 0; // 0: All, 1: Math, 2: Science, 3: English
  String _currentSort = "date"; // date, marks, percentage
  
  // Mock Data - Test Results
  final List<TestResult> _allTestResults = [
    TestResult(
      id: "1",
      testName: "Unit Test 1",
      chapterName: "Algebra Basics",
      chapterNumber: 1,
      subject: "Mathematics",
      testDate: DateTime(2024, 2, 15),
      totalMarks: 100,
      obtainedMarks: 85,
      percentage: 85.0,
      grade: "A",
      gradeColor: const Color(0xFF4CAF50),
    ),
    TestResult(
      id: "2",
      testName: "Chapter Test",
      chapterName: "Calculus Basics",
      chapterNumber: 3,
      subject: "Mathematics",
      testDate: DateTime(2024, 2, 20),
      totalMarks: 50,
      obtainedMarks: 42,
      percentage: 84.0,
      grade: "A",
      gradeColor: const Color(0xFF4CAF50),
    ),
    TestResult(
      id: "3",
      testName: "Weekly Assessment",
      chapterName: "Differential Equations",
      chapterNumber: 2,
      subject: "Mathematics",
      testDate: DateTime(2024, 2, 25),
      totalMarks: 75,
      obtainedMarks: 68,
      percentage: 90.7,
      grade: "A+",
      gradeColor: const Color(0xFF2196F3),
    ),
    TestResult(
      id: "4",
      testName: "Chap 2 Test",
      chapterName: "Geometry Fundamentals",
      chapterNumber: 4,
      subject: "Mathematics",
      testDate: DateTime(2024, 3, 5),
      totalMarks: 100,
      obtainedMarks: 72,
      percentage: 72.0,
      grade: "B",
      gradeColor: const Color(0xFFFF9800),
    ),
    TestResult(
      id: "5",
      testName: "Practical Test",
      chapterName: "Integration",
      chapterNumber: 5,
      subject: "Mathematics",
      testDate: DateTime(2024, 3, 12),
      totalMarks: 30,
      obtainedMarks: 25,
      percentage: 83.3,
      grade: "A",
      gradeColor: const Color(0xFF4CAF50),
    ),
    TestResult(
      id: "6",
      testName: "Vocabulary Test",
      chapterName: "Differential Equations",
      chapterNumber: 3,
      subject: "Mathematics",
      testDate: DateTime(2024, 3, 18),
      totalMarks: 50,
      obtainedMarks: 38,
      percentage: 76.0,
      grade: "B",
      gradeColor: const Color(0xFFFF9800),
    ),
    TestResult(
      id: "7",
      testName: "Unit Test 2",
      chapterName: "Trigonometry",
      chapterNumber: 6,
      subject: "Mathematics",
      testDate: DateTime(2024, 3, 25),
      totalMarks: 100,
      obtainedMarks: 91,
      percentage: 91.0,
      grade: "A+",
      gradeColor: const Color(0xFF2196F3),
    ),
    TestResult(
      id: "8",
      testName: "Biology Test",
      chapterName: "Differential Equations",
      chapterNumber: 4,
      subject: "Mathematics",
      testDate: DateTime(2024, 4, 2),
      totalMarks: 80,
      obtainedMarks: 65,
      percentage: 81.3,
      grade: "A",
      gradeColor: const Color(0xFF4CAF50),
    ),
    TestResult(
      id: "9",
      testName: "Literature Test",
      chapterName: "Differential Equations",
      chapterNumber: 4,
      subject: "Mathematics",
      testDate: DateTime(2024, 4, 10),
      totalMarks: 60,
      obtainedMarks: 48,
      percentage: 80.0,
      grade: "A",
      gradeColor: const Color(0xFF4CAF50),
    ),
    TestResult(
      id: "10",
      testName: "Final Term",
      chapterName: "Calculus Basics",
      chapterNumber: 8,
      subject: "Mathematics",
      testDate: DateTime(2024, 4, 20),
      totalMarks: 100,
      obtainedMarks: 78,
      percentage: 78.0,
      grade: "B+",
      gradeColor: const Color(0xFF9C27B0),
    ),
  ];

  List<TestResult> _filteredResults = [];

  @override
  void initState() {
    super.initState();
    _filteredResults = _allTestResults;
    _sortResults(_currentSort);
  }

  void _applyFilter(int filter) {
    setState(() {
      _currentFilter = filter;
      switch (filter) {
        case 1: // Mathematics
          _filteredResults = _allTestResults.where((result) => result.subject == "Mathematics").toList();
          break;
        case 2: // Science
          _filteredResults = _allTestResults.where((result) => result.subject == "Science").toList();
          break;
        case 3: // English
          _filteredResults = _allTestResults.where((result) => result.subject == "English").toList();
          break;
        default: // All
          _filteredResults = _allTestResults;
          break;
      }
      _sortResults(_currentSort);
    });
  }

  void _sortResults(String sortBy) {
    setState(() {
      _currentSort = sortBy;
      switch (sortBy) {
        case "date":
          _filteredResults.sort((a, b) => b.testDate.compareTo(a.testDate));
          break;
        case "marks":
          _filteredResults.sort((a, b) => b.obtainedMarks.compareTo(a.obtainedMarks));
          break;
        case "percentage":
          _filteredResults.sort((a, b) => b.percentage.compareTo(a.percentage));
          break;
      }
    });
  }

  double get _averagePercentage => _allTestResults.isNotEmpty 
      ? _allTestResults.map((r) => r.percentage).reduce((a, b) => a + b) / _allTestResults.length
      : 0.0;

  int get _totalTests => _allTestResults.length;
  int get _totalMarksObtained => _allTestResults.fold(0, (sum, result) => sum + result.obtainedMarks);
  int get _totalMarksPossible => _allTestResults.fold(0, (sum, result) => sum + result.totalMarks);

  String get _overallGrade {
    final avg = _averagePercentage;
    if (avg >= 90) return "A+";
    if (avg >= 80) return "A";
    if (avg >= 70) return "B";
    if (avg >= 60) return "C";
    return "D";
  }

  Color get _overallGradeColor {
    final avg = _averagePercentage;
    if (avg >= 90) return const Color(0xFF2196F3);
    if (avg >= 80) return const Color(0xFF4CAF50);
    if (avg >= 70) return const Color(0xFFFF9800);
    if (avg >= 60) return const Color(0xFF9C27B0);
    return const Color(0xFFFF6B6B);
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
              backgroundColor: const Color(0xFF2196F3).withOpacity(0.05),
            ),
          ),
          
          Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Panel - Summary & Filters
                    Expanded(
                      flex: 1,
                      child: _buildSummaryPanel(),
                    ),
                    
                    // Right Panel - Test Results
                    Expanded(
                      flex: 2,
                      child: _buildTestResultsPanel(),
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
                "Test Results & Performance",
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A237E),
                ),
              ),
              Text(
                widget.studentName,
                style: GoogleFonts.inter(fontSize: 18, color: Colors.grey[600]),
              ),
            ],
          ),
          const Spacer(),
          // Student Info Card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FB),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xFF2196F3).withOpacity(0.1),
                  child: Text(
                    widget.studentName[0],
                    style: const TextStyle(
                      color: Color(0xFF2196F3),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.className,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2C3E50),
                      ),
                    ),
                    Text(
                      "Roll: ${widget.rollNumber}",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.grey[600],
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

  Widget _buildSummaryPanel() {
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
              const Icon(Icons.assessment_rounded, color: Color(0xFF2196F3)),
              const SizedBox(width: 12),
              Text(
                "Performance Summary",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A237E),
                ),
              ),
            ],
          ),
          // const SizedBox(height: 32),
          
          // // Overall Grade
          // Container(
          //   padding: const EdgeInsets.all(24),
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [
          //         _overallGradeColor,
          //         _overallGradeColor.withOpacity(0.8),
          //       ],
          //       begin: Alignment.topLeft,
          //       end: Alignment.bottomRight,
          //     ),
          //     borderRadius: BorderRadius.circular(20),
          //     boxShadow: [
          //       BoxShadow(
          //         color: _overallGradeColor.withOpacity(0.3),
          //         blurRadius: 20,
          //         offset: const Offset(0, 10),
          //       ),
          //     ],
          //   ),
          //   child: Column(
          //     children: [
          //       Text(
          //         "Overall Grade",
          //         style: GoogleFonts.poppins(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w600,
          //           color: Colors.white.withOpacity(0.9),
          //         ),
          //       ),
          //       const SizedBox(height: 12),
          //       Text(
          //         _overallGrade,
          //         style: GoogleFonts.poppins(
          //           fontSize: 64,
          //           fontWeight: FontWeight.bold,
          //           color: Colors.white,
          //         ),
          //       ),
          //       Text(
          //         "${_averagePercentage.toStringAsFixed(1)}%",
          //         style: GoogleFonts.poppins(
          //           fontSize: 18,
          //           color: Colors.white.withOpacity(0.9),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(height: 32),
          
          // Stats
          _buildStatCard(
            "Total Tests",
            _totalTests.toString(),
            Icons.format_list_numbered_rounded,
            const Color(0xFF2196F3),
          ),
          const SizedBox(height: 16),
          
          _buildStatCard(
            "Marks Obtained",
            "$_totalMarksObtained/$_totalMarksPossible",
            Icons.score_rounded,
            const Color(0xFF4CAF50),
          ),
          const SizedBox(height: 16),
          
          _buildStatCard(
            "Average Score",
            "${_averagePercentage.toStringAsFixed(1)}%",
            Icons.trending_up_rounded,
            const Color(0xFF9C27B0),
          ),
          const SizedBox(height: 32),
          
          // Filters
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           
            ],
          ),
          const SizedBox(height: 32),
          
          // Sort Options
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sort By",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7FB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _currentSort,
                    icon: const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF2196F3)),
                    isExpanded: true,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF2C3E50),
                      fontWeight: FontWeight.w500,
                    ),
                    onChanged: (value) => _sortResults(value!),
                    items: const [
                      DropdownMenuItem(
                        value: "date",
                        child: Text("Date (Newest First)"),
                      ),
                      DropdownMenuItem(
                        value: "marks",
                        child: Text("Marks (Highest First)"),
                      ),
                      DropdownMenuItem(
                        value: "percentage",
                        child: Text("Percentage (Highest First)"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label, int index) {
    final isSelected = _currentFilter == index;
    return FilterChip(
      label: Text(label),
      labelStyle: GoogleFonts.inter(
        color: isSelected ? Colors.white : const Color(0xFF2196F3),
        fontWeight: FontWeight.w500,
      ),
      selected: isSelected,
      onSelected: (_) => _applyFilter(index),
      backgroundColor: const Color(0xFF2196F3).withOpacity(0.1),
      selectedColor: const Color(0xFF2196F3),
      checkmarkColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: const Color(0xFF2196F3).withOpacity(0.2)),
      ),
    );
  }

  Widget _buildTestResultsPanel() {
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
                const Icon(Icons.library_books_rounded, color: Color(0xFF2196F3)),
                const SizedBox(width: 12),
                Text(
                  "Test Results",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A237E),
                  ),
                ),
                const Spacer(),
                Text(
                  "${_filteredResults.length} tests",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          // Test Results Grid
          Expanded(
            child: _filteredResults.isEmpty
                ? _buildEmptyState()
                : GridView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.3,
                    ),
                    itemCount: _filteredResults.length,
                    itemBuilder: (context, index) {
                      final result = _filteredResults[index];
                      return _buildTestResultCard(result);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestResultCard(TestResult result) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: result.gradeColor.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subject & Chapter
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getSubjectColor(result.subject).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  result.subject,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: _getSubjectColor(result.subject),
                  ),
                ),
              ),
              // Grade Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: result.gradeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  result.grade,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: result.gradeColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Test Name & Chapter
          Text(
            result.testName,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Chapter ${result.chapterNumber}: ${result.chapterName}",
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          
          // Marks & Percentage
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Marks",
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${result.obtainedMarks}/${result.totalMarks}",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A237E),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Percentage",
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${result.percentage.toStringAsFixed(1)}%",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: result.percentage >= 80 
                            ? const Color(0xFF4CAF50)
                            : result.percentage >= 70
                                ? const Color(0xFFFF9800)
                                : const Color(0xFFFF6B6B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Performance",
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
                  Text(
                    "${(result.percentage / 100).toStringAsFixed(1)}",
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: result.gradeColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                height: 6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(3),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: result.percentage / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: result.gradeColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          
          // Date
          Row(
            children: [
              Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey[500]),
              const SizedBox(width: 6),
              Text(
                "${result.testDate.day}/${result.testDate.month}/${result.testDate.year}",
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  Color _getSubjectColor(String subject) {
    switch (subject.toLowerCase()) {
      case "mathematics":
        return const Color(0xFF2196F3);
      case "science":
        return const Color(0xFF4CAF50);
      case "english":
        return const Color(0xFFFF9800);
      default:
        return const Color(0xFF9C27B0);
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment_turned_in_rounded, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 20),
          Text(
            "No test results found",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Try changing your filter settings",
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