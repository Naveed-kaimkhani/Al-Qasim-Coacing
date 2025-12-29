import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/presentation/views/student/studen_list.dart';
import 'package:qr_code_scanner/presentation/views/student/student_registration_screen.dart';

// Main App with Drawer
class SchoolManagementApp extends StatefulWidget {
  const SchoolManagementApp({super.key});

  @override
  State<SchoolManagementApp> createState() => _SchoolManagementAppState();
}

class _SchoolManagementAppState extends State<SchoolManagementApp> {
  int _selectedIndex = 0;
  
  // Screens for navigation
  final List<Widget> _screens = [
    const StudentRegistrationScreen(),
    const StudentListScreen(),
    Container(color: Colors.white, child: const Center(child: Text('Dashboard'))),
    Container(color: Colors.white, child: const Center(child: Text('Attendance'))),
    Container(color: Colors.white, child: const Center(child: Text('Fee Management'))),
    Container(color: Colors.white, child: const Center(child: Text('Test Results'))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildNavigationDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A237E),
        elevation: 0,
        title: Text(
          _getAppBarTitle(),
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }

  Widget _buildNavigationDrawer() {
    return Container(
      width: 280,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF1A237E),
                  const Color(0xFF3949AB),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.school_rounded,
                      size: 40,
                      color: Color(0xFF1A237E),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'School Management',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Admin Dashboard',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              children: [
                // Dashboard
                _buildDrawerItem(
                  index: 0,
                  icon: Icons.dashboard_rounded,
                  title: 'Dashboard',
                ),
                
                const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20),
                
                // Student Management
                _buildDrawerSectionHeader('Student Management'),
                _buildDrawerItem(
                  index: 1,
                  icon: Icons.person_add_rounded,
                  title: 'Register Student',
                ),
                _buildDrawerItem(
                  index: 2,
                  icon: Icons.people_rounded,
                  title: 'Student Directory',
                ),
                
                const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20),
                
                // Academic Management
                _buildDrawerSectionHeader('Academic Management'),
                _buildDrawerItem(
                  index: 3,
                  icon: Icons.calendar_month_rounded,
                  title: 'Attendance',
                ),
                _buildDrawerItem(
                  index: 4,
                  icon: Icons.monetization_on_rounded,
                  title: 'Fee Management',
                ),
                _buildDrawerItem(
                  index: 5,
                  icon: Icons.assignment_rounded,
                  title: 'Test Results',
                ),
                _buildDrawerItem(
                  index: 6,
                  icon: Icons.assignment_turned_in_rounded,
                  title: 'Add Test Scores',
                ),
                
                const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20),
                
                // Settings
                _buildDrawerSectionHeader('Settings'),
                _buildDrawerItem(
                  index: 7,
                  icon: Icons.settings_rounded,
                  title: 'Settings',
                ),
                _buildDrawerItem(
                  index: 8,
                  icon: Icons.help_rounded,
                  title: 'Help & Support',
                ),
                _buildDrawerItem(
                  index: 9,
                  icon: Icons.logout_rounded,
                  title: 'Logout',
                  isLogout: true,
                ),
              ],
            ),
          ),
          
          // Footer
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(top: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/profile.png'), // Add your profile image
                  backgroundColor: Color(0xFF1A237E),
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admin User',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2C3E50),
                        ),
                      ),
                      Text(
                        'admin@school.edu',
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
        ],
      ),
    );
  }

  Widget _buildDrawerSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 20, bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.grey[500],
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required int index,
    required IconData icon,
    required String title,
    bool isLogout = false,
  }) {
    final isSelected = _selectedIndex == index;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Material(
        color: isSelected ? const Color(0xFF1A237E).withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            Navigator.pop(context); // Close drawer
            setState(() {
              _selectedIndex = index;
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 22,
                  color: isSelected 
                      ? const Color(0xFF1A237E)
                      : isLogout
                          ? const Color(0xFFFF6B6B)
                          : Colors.grey[600],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected
                          ? const Color(0xFF1A237E)
                          : isLogout
                              ? const Color(0xFFFF6B6B)
                              : const Color(0xFF2C3E50),
                    ),
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1A237E),
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getAppBarTitle() {
    switch (_selectedIndex) {
      case 0: return 'Dashboard';
      case 1: return 'Register Student';
      case 2: return 'Student Directory';
      case 3: return 'Attendance Management';
      case 4: return 'Fee Management';
      case 5: return 'Test Results';
      case 6: return 'Add Test Scores';
      case 7: return 'Settings';
      case 8: return 'Help & Support';
      case 9: return 'Logout';
      default: return 'School Management';
    }
  }
}