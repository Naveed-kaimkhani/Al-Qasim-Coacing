import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/data/models/student.dart';
import 'package:qr_code_scanner/presentation/views/student/student_details_screen.dart';
import 'package:qr_code_scanner/presentation/views/student/student_registration_screen.dart';

// Model for Student Data


class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // Mock Data
  final List<Student> _allStudents = [
    Student(name: "Arjun Sharma", fatherName: "Rajesh Sharma", className: "Grade 10", rollNumber: "1001", accentColor: Colors.blue),
    Student(name: "Sara Khan", fatherName: "Ahmed Khan", className: "Grade 12", rollNumber: "1205", accentColor: Colors.purple),
    Student(name: "Liam Wilson", fatherName: "Robert Wilson", className: "Grade 8", rollNumber: "0812", accentColor: Colors.orange),
    Student(name: "Priya Patel", fatherName: "Vikram Patel", className: "Grade 11", rollNumber: "1140", accentColor: Colors.pink),
    Student(name: "Ethan Davis", fatherName: "John Davis", className: "Grade 9", rollNumber: "0922", accentColor: Colors.teal),
    Student(name: "Anya Taylor", fatherName: "Chris Taylor", className: "Grade 10", rollNumber: "1044", accentColor: Colors.indigo),
  ];

  List<Student> _filteredStudents = [];
  bool _isHoveredAddButton = false;

  @override
  void initState() {
    super.initState();
    _filteredStudents = _allStudents;
  }

  void _filterList(String query) {
    setState(() {
      _filteredStudents = _allStudents
          .where((s) => s.name.toLowerCase().contains(query.toLowerCase()) || 
                        s.rollNumber.contains(query))
          .toList();
    });
  }

  void _addStudent() {
    print('Add Student button pressed');
    // Get.to(() => StudentRegistrationScreen());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StudentRegistrationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      floatingActionButton: _buildAddStudentButton(),
      body: Stack(
        children: [
          // Background Decoration
          Positioned(
            top: -100,
            right: -100,
            child: CircleAvatar(radius: 200, backgroundColor: Colors.blue.withOpacity(0.05)),
          ),
          
          Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _filteredStudents.isEmpty 
                  ? _buildEmptyState() 
                  : _buildStudentGrid(),
              ),
            ],
          ),
        ],
      ),
    );
  }
 void _showAddStudentModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddStudentModal(),
    );
  }
  Widget _buildAddStudentButton() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHoveredAddButton = true),
      onExit: (_) => setState(() => _isHoveredAddButton = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _showAddStudentModal,
        child: AnimatedContainer(
          duration: 300.ms,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF6A11CB),
                const Color(0xFF2575FC),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2575FC).withOpacity(_isHoveredAddButton ? 0.4 : 0.2),
                blurRadius: _isHoveredAddButton ? 25 : 15,
                spreadRadius: _isHoveredAddButton ? 2 : 0,
                offset: Offset(0, _isHoveredAddButton ? 8 : 4),
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: 300.ms,
                width: _isHoveredAddButton ? 32 : 28,
                height: _isHoveredAddButton ? 32 : 28,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.add,
                  size: _isHoveredAddButton ? 20 : 18,
                  color: const Color(0xFF2575FC),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Add Student",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 8),
              AnimatedOpacity(
                duration: 300.ms,
                opacity: _isHoveredAddButton ? 1 : 0,
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 18,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        )
        .animate(
          onPlay: (controller) => controller.repeat(reverse: true),
        )
        .scale(end: Offset(1.02,1.02 ), duration: 1500.ms, curve: Curves.easeInOut)
        .then()
        .scale(end: Offset(1.0,1.0), duration: 1500.ms, curve: Curves.easeInOut),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20)],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Student Directory",
                style: GoogleFonts.poppins(
                  fontSize: 32, 
                  fontWeight: FontWeight.bold, 
                  color: const Color(0xFF1A237E)
                ),
              ),
              Text(
                "Managing ${_allStudents.length} total students",
                style: GoogleFonts.inter(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),
          const Spacer(),
          // Search Bar
          Container(
            width: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _filterList,
              decoration: const InputDecoration(
                hintText: "Search by name or roll number...",
                prefixIcon: Icon(Icons.search, color: Colors.blue),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
          const SizedBox(width: 20),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.filter_list),
            label: const Text("Filters"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              side: const BorderSide(color: Color(0xFFBBDEFB)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(40),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        mainAxisExtent: 200,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
      ),
      itemCount: _filteredStudents.length,
      itemBuilder: (context, index) {
        final student = _filteredStudents[index];
        return StudentCard(student: student)
            .animate(delay: (100 * index).ms)
            .fadeIn(duration: 500.ms)
            .moveY(begin: 20, end: 0);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_search_rounded, size: 100, color: Colors.grey[300]),
          const SizedBox(height: 20),
          Text(
            "No students found",
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey[400]),
          ),
        ],
      ).animate().fadeIn(),
    );
  }
}

class StudentCard extends StatefulWidget {
  final Student student;
  const StudentCard({super.key, required this.student});

  @override
  State<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentDetailsScreen(student:widget.student),
          ),
        );
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: 200.ms,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered ? widget.student.accentColor.withOpacity(0.5) : Colors.transparent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered 
                    ? widget.student.accentColor.withOpacity(0.1) 
                    : Colors.black.withOpacity(0.03),
                blurRadius: _isHovered ? 30 : 10,
                offset: Offset(0, _isHovered ? 10 : 4),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: widget.student.accentColor.withOpacity(0.1),
                    child: Text(
                      widget.student.name[0],
                      style: TextStyle(color: widget.student.accentColor, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.student.name,
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF2C3E50)),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Roll No: ${widget.student.rollNumber}",
                          style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[500], fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[300]),
                ],
              ),
              const Spacer(),
              const Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoTag(Icons.school_outlined, widget.student.className),
                  _buildInfoTag(Icons.family_restroom_outlined, widget.student.fatherName),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTag(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.blueGrey[300]),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 13, color: Colors.blueGrey[600], fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

 void _showAddStudentModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddStudentModal(),
    );
  }

}


// Add Student Modal
class AddStudentModal extends StatefulWidget {
  const AddStudentModal({super.key});

  @override
  State<AddStudentModal> createState() => _AddStudentModalState();
}

class _AddStudentModalState extends State<AddStudentModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _classNameController = TextEditingController();
  final TextEditingController _rollNumberController = TextEditingController();
  
  final List<Color> _availableColors = const [
    Color(0xFF4361EE),
    Color(0xFF7209B7),
    Color(0xFFF8961E),
    Color(0xFF4CAF50),
    Color(0xFFEF476F),
    Color(0xFF06D6A0),
  ];
  
  Color _selectedColor = const Color(0xFF4361EE);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 40,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative Background
          Positioned(
            top: -50,
            right: -50,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: _selectedColor.withOpacity(0.05),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: CircleAvatar(
              radius: 150,
              backgroundColor: _selectedColor.withOpacity(0.03),
            ),
          ),
          
          SingleChildScrollView(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person_add_alt_1_rounded, 
                         size: 32, 
                         color: _selectedColor),
                    const SizedBox(width: 16),
                    Text(
                      "Register New Student",
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A237E),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded, size: 28),
                      color: Colors.grey[400],
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Color Selection
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Profile Color",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF2C3E50),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: _availableColors.map((color) {
                              return InkWell(
                                onTap: () => setState(() => _selectedColor = color),
                                borderRadius: BorderRadius.circular(20),
                                child: AnimatedContainer(
                                  duration: 300.ms,
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: color,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: _selectedColor == color
                                          ? Colors.white
                                          : Colors.transparent,
                                      width: 3,
                                    ),
                                    boxShadow: _selectedColor == color
                                        ? [
                                            BoxShadow(
                                              color: color.withOpacity(0.5),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ]
                                        : null,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      
                      // Form Fields
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: _nameController,
                              label: "Student Name",
                              hint: "Enter full name",
                              icon: Icons.person_outline_rounded,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter student name';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: _buildTextField(
                              controller: _fatherNameController,
                              label: "Father's Name",
                              hint: "Enter father's name",
                              icon: Icons.family_restroom_outlined,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter father\'s name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: _classNameController,
                              label: "Class/Grade",
                              hint: "e.g., Grade 10",
                              icon: Icons.school_outlined,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter class';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: _buildTextField(
                              controller: _rollNumberController,
                              label: "Roll Number",
                              hint: "e.g., 1001",
                              icon: Icons.confirmation_number_outlined,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter roll number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60),
                      
                      // Submit Button
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Handle form submission
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Student ${_nameController.text} registered successfully!',
                                    style: GoogleFonts.poppins(),
                                  ),
                                  backgroundColor: _selectedColor,
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.add_circle_outline_rounded),
                          label: const Text("Register Student"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 60,
                              vertical: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 8,
                            shadowColor: _selectedColor.withOpacity(0.5),
                          ),
                        ).animate().scale(delay: 300.ms),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: Colors.grey[400]),
            prefixIcon: Icon(icon, color: _selectedColor),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: _selectedColor, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
          ),
          style: GoogleFonts.inter(fontSize: 15),
        ),
      ],
    );
  }
}