// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:lottie/lottie.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:qr_code_scanner/components/animated_background.dart';
// import 'package:qr_code_scanner/components/animated_button.dart';
// import 'package:qr_code_scanner/components/animated_formField.dart';

// class StudentRegistrationScreen extends HookWidget {
//   const StudentRegistrationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final formKey = useMemoized(() => GlobalKey<FormState>());
//     final nameController = useTextEditingController();
//     final fatherNameController = useTextEditingController();
//     final rollNumberController = useTextEditingController();
//     final passwordController = useTextEditingController();
//     final selectedClass = useState<String?>(null);
//     final showPassword = useState(false);
//     final isSubmitting = useState(false);
//     final animationController = useAnimationController(duration: 2.seconds);

//     useEffect(() {
//       animationController.forward();
//       return null;
//     }, []);

//     final classes = [
//       'Kindergarten',
//       'Grade 1',
//       'Grade 2',
//       'Grade 3',
//       'Grade 4',
//       'Grade 5',
//       'Grade 6',
//       'Grade 7',
//       'Grade 8',
//       'Grade 9',
//       'Grade 10',
//       'Grade 11',
//       'Grade 12'
//     ];

//     Future<void> submitForm() async {
//       if (!formKey.currentState!.validate()) return;

//       isSubmitting.value = true;
//       await Future.delayed(2.seconds);
//       isSubmitting.value = false;

//       // Show success animation
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           backgroundColor: Colors.white.withOpacity(0.95),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Lottie.asset(
//                 'assets/lottie/Success.json',
//                 width: 150,
//                 height: 150,
//                 repeat: false,
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Registration Successful!',
//                 style: GoogleFonts.poppins(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w700,
//                   color: const Color(0xFF4CAF50),
//                   letterSpacing: 0.5,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 'Student has been registered successfully.',
//                 style: GoogleFonts.inter(
//                   fontSize: 14,
//                   color: Colors.grey[700],
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text(
//                 'OK',
//                 style: GoogleFonts.inter(
//                   fontWeight: FontWeight.w600,
//                   color: const Color(0xFF1E88E5),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return Scaffold(
//       body: Stack(
//         children: [
//           // Animated Background with Gradient and Shapes
//           AnimatedBackground(),
          
//           // Main Content
//           Center(
//             child: SingleChildScrollView(
//               child: Container(
//                 constraints: const BoxConstraints(maxWidth: 1200),
//                 padding: const EdgeInsets.all(40),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     // Left Side - Illustration
//                     Expanded(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(30),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(30),
//                               border: Border.all(
//                                 color: Colors.white.withOpacity(0.2),
//                               ),
//                             ),
//                             child: Stack(
//                               alignment: Alignment.center,
//                               children: [
//                                 // Animated Book Illustration
//                                 Positioned(
//                                   right: 20,
//                                   top: 20,
//                                   child: Icon(
//                                     Icons.menu_book_rounded,
//                                     size: 80,
//                                     color: Colors.white.withOpacity(0.3),
//                                   ),
//                                 ),
//                                 Lottie.asset(
//                                   'assets/lottie/education.json',
//                                   width: 400,
//                                   height: 400,
//                                   controller: animationController,
//                                   repeat: true,
//                                   reverse: false,
//                                   animate: true,
//                                 ),
//                               ],
//                             ),
//                           ).animate().fadeIn(duration: 800.ms),
//                           const SizedBox(height: 40),
//                           Text(
//                             'Join Our Learning Community',
//                             style: GoogleFonts.poppins(
//                               fontSize: 36,
//                               fontWeight: FontWeight.w700,
//                               color: Colors.white,
//                               letterSpacing: 0.5,
//                               height: 1.2,
//                             ),
//                           ).animate().slideY(
//                                 duration: 600.ms,
//                                 begin: 0.5,
//                                 curve: Curves.easeOut,
//                               ),
//                           const SizedBox(height: 10),
//                           Text(
//                             'Fill in the details to register as a new student',
//                             style: GoogleFonts.inter(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.white.withOpacity(0.8),
//                               letterSpacing: 0.3,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(width: 60),

//                     // Right Side - Registration Form
//                     Expanded(
//                       child: Container(
//                         padding: const EdgeInsets.all(40),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.95),
//                           borderRadius: BorderRadius.circular(30),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 30,
//                               spreadRadius: 5,
//                               offset: const Offset(0, 10),
//                             ),
//                           ],
//                         ),
//                         child: Form(
//                           key: formKey,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               // Header
//                               Row(
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.all(12),
//                                     decoration: BoxDecoration(
//                                       color: const Color(0xFF1E88E5),
//                                       borderRadius: BorderRadius.circular(15),
//                                       gradient: LinearGradient(
//                                         begin: Alignment.topLeft,
//                                         end: Alignment.bottomRight,
//                                         colors: [
//                                           const Color(0xFF1E88E5),
//                                           const Color(0xFF4CAF50).withOpacity(0.8),
//                                         ],
//                                       ),
//                                     ),
//                                     child: const Icon(
//                                       Icons.person_add_alt_1_rounded,
//                                       color: Colors.white,
//                                       size: 32,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 20),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'Student Registration',
//                                           style: GoogleFonts.poppins(
//                                             fontSize: 28,
//                                             fontWeight: FontWeight.w700,
//                                             color: const Color(0xFF1E88E5),
//                                             letterSpacing: 0.5,
//                                             height: 1.2,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 4),
//                                         Text(
//                                           'Enter student details below',
//                                           style: GoogleFonts.inter(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w500,
//                                             color: Colors.grey[600],
//                                             letterSpacing: 0.3,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ).animate().fadeIn(delay: 300.ms),

//                               const SizedBox(height: 40),

//                               // Student Name
//                               AnimatedFormField(
//                                 delay: 400.ms,
//                                 child: TextFormField(
//                                   controller: nameController,
//                                   style: GoogleFonts.inter(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   decoration: InputDecoration(
//                                     labelText: 'Student Name',
//                                     labelStyle: GoogleFonts.inter(
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.grey[700],
//                                     ),
//                                     prefixIcon: const Icon(Icons.person_outline),
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: BorderSide(
//                                         color: Colors.grey[300]!,
//                                         width: 1.5,
//                                       ),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: BorderSide(
//                                         color: Colors.grey[300]!,
//                                         width: 1.5,
//                                       ),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: const BorderSide(
//                                         color: Color(0xFF1E88E5),
//                                         width: 2,
//                                       ),
//                                     ),
//                                   ),
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Please enter student name';
//                                     }
//                                     if (value.length < 2) {
//                                       return 'Name must be at least 2 characters';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                               ),

//                               const SizedBox(height: 20),

//                               // Father's Name
//                               AnimatedFormField(
//                                 delay: 500.ms,
//                                 child: TextFormField(
//                                   controller: fatherNameController,
//                                   style: GoogleFonts.inter(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   decoration: InputDecoration(
//                                     labelText: 'Father\'s Name',
//                                     labelStyle: GoogleFonts.inter(
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.grey[700],
//                                     ),
//                                     prefixIcon: const Icon(Icons.family_restroom),
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: BorderSide(
//                                         color: Colors.grey[300]!,
//                                         width: 1.5,
//                                       ),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: BorderSide(
//                                         color: Colors.grey[300]!,
//                                         width: 1.5,
//                                       ),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: const BorderSide(
//                                         color: Color(0xFF1E88E5),
//                                         width: 2,
//                                       ),
//                                     ),
//                                   ),
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Please enter father\'s name';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                               ),

//                               const SizedBox(height: 20),

//                               // Class Dropdown
//                               AnimatedFormField(
//                                 delay: 600.ms,
//                                 child: DropdownButtonFormField<String>(
//                                   value: selectedClass.value,
//                                   style: GoogleFonts.inter(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.black87,
//                                   ),
//                                   decoration: InputDecoration(
//                                     labelText: 'Class',
//                                     labelStyle: GoogleFonts.inter(
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.grey[700],
//                                     ),
//                                     prefixIcon: const Icon(Icons.school_outlined),
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: BorderSide(
//                                         color: Colors.grey[300]!,
//                                         width: 1.5,
//                                       ),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: BorderSide(
//                                         color: Colors.grey[300]!,
//                                         width: 1.5,
//                                       ),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: const BorderSide(
//                                         color: Color(0xFF1E88E5),
//                                         width: 2,
//                                       ),
//                                     ),
//                                   ),
//                                   dropdownColor: Colors.white,
//                                   items: classes.map((String value) {
//                                     return DropdownMenuItem<String>(
//                                       value: value,
//                                       child: Text(
//                                         value,
//                                         style: GoogleFonts.inter(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                     );
//                                   }).toList(),
//                                   onChanged: (value) {
//                                     selectedClass.value = value;
//                                   },
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Please select a class';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                               ),

//                               const SizedBox(height: 20),

//                               // Roll Number
//                               AnimatedFormField(
//                                 delay: 700.ms,
//                                 child: TextFormField(
//                                   controller: rollNumberController,
//                                   style: GoogleFonts.inter(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   decoration: InputDecoration(
//                                     labelText: 'Roll Number',
//                                     labelStyle: GoogleFonts.inter(
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.grey[700],
//                                     ),
//                                     prefixIcon: const Icon(Icons.confirmation_number),
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: BorderSide(
//                                         color: Colors.grey[300]!,
//                                         width: 1.5,
//                                       ),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: BorderSide(
//                                         color: Colors.grey[300]!,
//                                         width: 1.5,
//                                       ),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: const BorderSide(
//                                         color: Color(0xFF1E88E5),
//                                         width: 2,
//                                       ),
//                                     ),
//                                   ),
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Please enter roll number';
//                                     }
//                                     if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
//                                       return 'Roll number must be numeric';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                               ),

//                               const SizedBox(height: 20),

//                               // Password Field
//                               AnimatedFormField(
//                                 delay: 800.ms,
//                                 child: TextFormField(
//                                   controller: passwordController,
//                                   obscureText: !showPassword.value,
//                                   style: GoogleFonts.inter(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   decoration: InputDecoration(
//                                     labelText: 'Password',
//                                     labelStyle: GoogleFonts.inter(
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.grey[700],
//                                     ),
//                                     prefixIcon: const Icon(Icons.lock_outline),
//                                     suffixIcon: IconButton(
//                                       icon: Icon(
//                                         showPassword.value
//                                             ? Icons.visibility_off
//                                             : Icons.visibility,
//                                         color: const Color(0xFF1E88E5),
//                                       ),
//                                       onPressed: () {
//                                         showPassword.value = !showPassword.value;
//                                       },
//                                     ),
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: BorderSide(
//                                         color: Colors.grey[300]!,
//                                         width: 1.5,
//                                       ),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: BorderSide(
//                                         color: Colors.grey[300]!,
//                                         width: 1.5,
//                                       ),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: const BorderSide(
//                                         color: Color(0xFF1E88E5),
//                                         width: 2,
//                                       ),
//                                     ),
//                                   ),
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Please enter password';
//                                     }
//                                     if (value.length < 6) {
//                                       return 'Password must be at least 6 characters';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                               ),

//                               const SizedBox(height: 40),

//                               // Register Button
//                               AnimatedButton(
//                                 delay: 900.ms,
//                                 child: ElevatedButton(
//                                   onPressed: isSubmitting.value ? null : submitForm,
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: const Color(0xFF1E88E5),
//                                     foregroundColor: Colors.white,
//                                     padding: const EdgeInsets.symmetric(
//                                       vertical: 22,
//                                       horizontal: 40,
//                                     ),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(15),
//                                     ),
//                                     elevation: 8,
//                                     shadowColor: const Color(0xFF1E88E5)
//                                         .withOpacity(0.4),
//                                   ),
//                                   child: isSubmitting.value
//                                       ? SizedBox(
//                                           width: 24,
//                                           height: 24,
//                                           child: CircularProgressIndicator(
//                                             strokeWidth: 2.5,
//                                             valueColor: AlwaysStoppedAnimation(
//                                               Colors.white,
//                                             ),
//                                           ),
//                                         )
//                                       : Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             const Icon(Icons.person_add_rounded),
//                                             const SizedBox(width: 12),
//                                             Text(
//                                               'REGISTER STUDENT',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w700,
//                                                 letterSpacing: 0.8,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ).animate().slideX(
//                             duration: 800.ms,
//                             begin: 1,
//                             curve: Curves.easeOut,
//                           ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';


class StudentRegistrationScreen extends StatefulWidget {
  const StudentRegistrationScreen({super.key});

  @override
  State<StudentRegistrationScreen> createState() => _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _rollNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  
  String? _selectedClass;
  bool _showPassword = false;
  bool _isSubmitting = false;

  final List<String> _classes = [
    'Kindergarten', 'Grade 1', 'Grade 2', 'Grade 3', 'Grade 4', 
    'Grade 5', 'Grade 6', 'Grade 7', 'Grade 8', 'Grade 9', 
    'Grade 10', 'Grade 11', 'Grade 12'
  ];

  Future<void> _handleRegistration() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    // Simulate network latency
    await Future.delayed(2.seconds);
    setState(() => _isSubmitting = false);

    if (mounted) _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 40)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle_outline_rounded, color: Colors.green, size: 80)
                  .animate().scale(duration: 400.ms, curve: Curves.easeInBack),
              const SizedBox(height: 24),
              Text(
                'Registration Successful!',
                style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const SizedBox(height: 12),
              Text(
                'Student record has been created.',
                style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 16),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E88E5),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('CONTINUE', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ).animate().scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutCubic),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _AnimatedBackground(),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    bool isDesktop = constraints.maxWidth > 900;
                    return Flex(
                      direction: isDesktop ? Axis.horizontal : Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left Branding/Illustration
                        Expanded(
                          flex: isDesktop ? 1 : 0,
                          child: Column(
                            crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(40),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                                ),
                                child: const Icon(Icons.person_add_rounded, size: 160, color: Colors.white70)
                                    .animate(onPlay: (c) => c.repeat())
                                    .moveY(begin: -10, end: 10, duration: 2.seconds, curve: Curves.easeInOut),
                              ).animate().fadeIn(duration: 800.ms).scale(),
                              const SizedBox(height: 40),
                              Text(
                                'Join Our Learning\nCommunity',
                                textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  height: 1.1,
                                ),
                              ).animate().slideY(begin: 0.2, duration: 600.ms),
                              const SizedBox(height: 16),
                              Text(
                                'Empowering the next generation of thinkers.',
                                textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                                style: GoogleFonts.inter(fontSize: 18, color: Colors.white.withOpacity(0.8)),
                              ),
                            ],
                          ),
                        ),
                        if (isDesktop) const SizedBox(width: 100),
                        // Right Side - Registration Form
                        Expanded(
                          flex: isDesktop ? 1 : 0,
                          child: Container(
                            margin: isDesktop ? EdgeInsets.zero : const EdgeInsets.only(top: 40),
                            padding: const EdgeInsets.all(48),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.96),
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 40, offset: const Offset(0, 15))
                              ],
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _HeaderSection(),
                                  const SizedBox(height: 40),
                                  _CustomTextField(
                                    controller: _nameController,
                                    label: 'Student Name',
                                    icon: Icons.person_outline,
                                    validator: (v) => v!.length < 2 ? 'Minimum 2 characters' : null,
                                  ),
                                  const SizedBox(height: 20),
                                  _CustomTextField(
                                    controller: _fatherNameController,
                                    label: "Father's Name",
                                    icon: Icons.family_restroom_outlined,
                                  ),
                                  const SizedBox(height: 20),
                                  _CustomDropdown(
                                    value: _selectedClass,
                                    items: _classes,
                                    onChanged: (v) => setState(() => _selectedClass = v),
                                  ),
                                  const SizedBox(height: 20),
                                  _CustomTextField(
                                    controller: _rollNumberController,
                                    label: 'Roll Number',
                                    icon: Icons.numbers_outlined,
                                    keyboardType: TextInputType.number,
                                    validator: (v) => !RegExp(r'^\d+$').hasMatch(v!) ? 'Enter numeric roll number' : null,
                                  ),
                                  const SizedBox(height: 20),
                                  _CustomTextField(
                                    controller: _passwordController,
                                    label: 'Password',
                                    icon: Icons.lock_outline_rounded,
                                    obscureText: !_showPassword,
                                    suffix: IconButton(
                                      icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
                                      onPressed: () => setState(() => _showPassword = !_showPassword),
                                    ),
                                    validator: (v) => v!.length < 6 ? 'Minimum 6 characters' : null,
                                  ),
                                  const SizedBox(height: 40),
                                  _RegisterButton(
                                    isLoading: _isSubmitting,
                                    onPressed: _handleRegistration,
                                  ),
                                ],
                              ),
                            ),
                          ).animate().slideX(begin: 0.1, duration: 800.ms, curve: Curves.easeOutCubic),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF1E88E5), Color(0xFF43A047)]),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.school_rounded, color: Colors.white, size: 28),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Student Registration',
                style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.bold, color: const Color(0xFF1E88E5))),
            Text('Academic Session 2024-25',
                style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[600])),
          ],
        ),
      ],
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;
  final Widget? suffix;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const _CustomTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.suffix,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: GoogleFonts.inter(fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 22),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey[200]!)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 2)),
      ),
      validator: validator ?? (v) => v == null || v.isEmpty ? 'This field is required' : null,
    );
  }
}

class _CustomDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;

  const _CustomDropdown({this.value, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: 'Class',
        prefixIcon: const Icon(Icons.class_outlined, size: 22),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey[200]!)),
      ),
      validator: (v) => v == null ? 'Please select a class' : null,
    );
  }
}

class _RegisterButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const _RegisterButton({required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: const Color(0xFF1E88E5).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E88E5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: isLoading
            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3))
            : Text('REGISTER STUDENT', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.2)),
      ),
    ).animate(onPlay: (c) => c.repeat(reverse: true))
     .shimmer(delay: 3.seconds, duration: 1500.ms, color: Colors.white24);
  }
}

class _AnimatedBackground extends StatelessWidget {
  const _AnimatedBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E88E5), Color(0xFF1565C0), Color(0xFF43A047)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -150,
            left: -150,
            child: _FloatingOrb(color: Colors.white.withOpacity(0.05), size: 500),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: _FloatingOrb(color: Colors.blue.withOpacity(0.1), size: 600),
          ),
        ],
      ),
    );
  }
}

class _FloatingOrb extends StatelessWidget {
  final Color color;
  final double size;
  const _FloatingOrb({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    ).animate(onPlay: (c) => c.repeat(reverse: true))
     .moveX(begin: -30, end: 30, duration: 8.seconds, curve: Curves.easeInOut)
     .moveY(begin: -20, end: 20, duration: 6.seconds, curve: Curves.easeInOut);
  }
}