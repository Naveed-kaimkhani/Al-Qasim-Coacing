
// Add Student Modal
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/components/add_student_fab.dart';
import 'package:qr_code_scanner/components/add_student_modal.dart';
import 'package:qr_code_scanner/components/empty_state.dart';
import 'package:qr_code_scanner/components/student_card.dart';
import 'package:qr_code_scanner/components/student_grid.dart';
import 'package:qr_code_scanner/components/student_header.dart';
import 'package:qr_code_scanner/data/mock/student_mock_data.dart';
import 'package:qr_code_scanner/data/models/student.dart';
import 'package:qr_code_scanner/presentation/views/admin_module/student_details_screen.dart';

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
