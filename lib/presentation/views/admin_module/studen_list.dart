import 'package:flutter/material.dart';
import 'package:qr_code_scanner/components/add_student_button.dart';
import 'package:qr_code_scanner/components/add_student_fab.dart';
import 'package:qr_code_scanner/components/empty_state.dart';
import 'package:qr_code_scanner/components/student_grid.dart';
import 'package:qr_code_scanner/components/student_header.dart';
import 'package:qr_code_scanner/data/mock/student_mock_data.dart';
import 'package:qr_code_scanner/data/models/student.dart';



class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Student> _students = mockStudents;
  late List<Student> _filteredStudents;

  @override
  void initState() {
    super.initState();
    _filteredStudents = _students;
  }

  void _onSearch(String query) {
    setState(() {
      _filteredStudents = _students
          .where((s) =>
              s.name.toLowerCase().contains(query.toLowerCase()) ||
              s.rollNumber.contains(query))
          .toList();
    });
  }

  void _openAddStudent() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AddStudentModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      floatingActionButton: AddStudentButton(onTap: _openAddStudent),
      body: Column(
        children: [
        StudentListHeader(
  totalStudents: _filteredStudents.length,
  searchController: _searchController,
  onSearch: _onSearch,
  onFilterTap: () {
    // open filter dialog
  },
),
          Expanded(
            child: _filteredStudents.isEmpty
                ? const StudentEmptyState()
                : StudentGrid(students: _filteredStudents),
          ),
        ],
      ),
    );
  }
}
