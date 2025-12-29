


import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/components/animated_background.dart' show AnimatedBackground;
import 'package:qr_code_scanner/components/custom_textfield.dart';
import 'package:qr_code_scanner/presentation/views/admin_module/studen_list.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _showPassword = false;
  bool _isLoggingIn = false;
  bool _rememberMe = false;

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoggingIn = true);
    
    // Simulate network latency
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() => _isLoggingIn = false);

    // Navigate to student list after successful login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const StudentListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedBackground(),
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
                                child: const Icon(Icons.admin_panel_settings_rounded, size: 160, color: Colors.white70)
                                    .animate(onPlay: (c) => c.repeat())
                                    .moveY(begin: -10, end: 10, duration: Duration(seconds: 2), curve: Curves.easeInOut),
                              ).animate().fadeIn(duration: 800.ms).scale(),
                              const SizedBox(height: 40),
                              Text(
                                'Al Qasim Coaching\nManagement',
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
                                'Admin Portal - Secure Access',
                                textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                                style: GoogleFonts.inter(fontSize: 18, color: Colors.white.withOpacity(0.8)),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Manage students, attendance, fees & more',
                                textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                                style: GoogleFonts.inter(fontSize: 14, color: Colors.white.withOpacity(0.7)),
                              ),
                            ],
                          ),
                        ),
                        if (isDesktop) const SizedBox(width: 100),
                        // Right Side - Login Form
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
                                  CustomTextField(
                                    controller: _emailController,
                                    label: 'Admin Email',
                                    icon: Icons.email_outlined,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (v) {
                                      if (v == null || v.isEmpty) return 'Email is required';
                                      if (!v.contains('@') || !v.contains('.')) return 'Enter valid email';
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextField(
                                    controller: _passwordController,
                                    label: 'Password',
                                    icon: Icons.lock_outline_rounded,
                                    obscureText: !_showPassword,
                                    suffix: IconButton(
                                      icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
                                      onPressed: () => setState(() => _showPassword = !_showPassword),
                                    ),
                                    validator: (v) {
                                      if (v == null || v.isEmpty) return 'Password is required';
                                      if (v.length < 6) return 'Minimum 6 characters';
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  
                                  // Remember Me & Forgot Password
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: _rememberMe,
                                            onChanged: (value) => setState(() => _rememberMe = value ?? false),
                                            activeColor: const Color(0xFF1E88E5),
                                          ),
                                          Text(
                                            'Remember me',
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Forgot password action
                                        },
                                        child: Text(
                                          'Forgot Password?',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF1E88E5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  const SizedBox(height: 40),
                                  _LoginButton(
                                    isLoading: _isLoggingIn,
                                    onPressed: _handleLogin,
                                  ),
                                  
                                  const SizedBox(height: 30),
                                  // Divider with OR text
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          color: Colors.grey[300],
                                          thickness: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Text(
                                          'or continue with',
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: Colors.grey[300],
                                          thickness: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 40),
                                  // Sign up link
                                  Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        // Navigate to registration screen
                                      },
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Don\'t have admin access? ',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'Request Access',
                                              style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xFF1E88E5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
          child: const Icon(Icons.admin_panel_settings_rounded, color: Colors.white, size: 28),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Admin Login',
                style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.bold, color: const Color(0xFF1E88E5))),
            Text('Secure School Management Portal',
                style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[600])),
          ],
        ),
      ],
    );
  }
}


class _LoginButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const _LoginButton({required this.isLoading, required this.onPressed});

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
            : Text('LOGIN TO DASHBOARD', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.2)),
      ),
    ).animate(onPlay: (c) => c.repeat(reverse: true))
     .shimmer(delay: Duration(seconds: 1), duration: 1500.ms, color: Colors.white24);
  }
}

