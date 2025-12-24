import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';


class StudentListApp extends StatelessWidget {
  const StudentListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduManage Pro - Student List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
          brightness: Brightness.light,
          primary: const Color(0xFF1E88E5),
          secondary: const Color(0xFF4CAF50),
          tertiary: const Color(0xFFFFC107),
        ),
      ),
      home: const StudentListScreen(),
    );
  }
}

// Student Data Model
class Student {
  final String id;
  final String name;
  final String fatherName;
  final String className;
  final String? avatarUrl;
  final DateTime registrationDate;
  final String rollNumber;
  final double attendancePercentage;

  Student({
    required this.id,
    required this.name,
    required this.fatherName,
    required this.className,
    this.avatarUrl,
    required this.registrationDate,
    required this.rollNumber,
    this.attendancePercentage = 95.0,
  });
}

class StudentListScreen extends HookWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final selectedClassFilter = useState<String?>(null);
    final sortBy = useState<String>('name');
    final hoveredIndex = useState<int?>(null);
    final selectedStudents = useState<Set<String>>({});
    final isGridView = useState<bool>(false);

    // Mock student data
    final students = useState<List<Student>>([
      Student(
        id: '1',
        name: 'Aarav Sharma',
        fatherName: 'Rajesh Sharma',
        className: 'Grade 10',
        rollNumber: '101',
        registrationDate: DateTime(2024, 1, 15),
        attendancePercentage: 96.5,
      ),
      Student(
        id: '2',
        name: 'Priya Patel',
        fatherName: 'Sanjay Patel',
        className: 'Grade 9',
        rollNumber: '102',
        registrationDate: DateTime(2024, 2, 20),
        attendancePercentage: 92.0,
      ),
      Student(
        id: '3',
        name: 'Rohan Singh',
        fatherName: 'Vikram Singh',
        className: 'Grade 11',
        rollNumber: '103',
        registrationDate: DateTime(2024, 1, 10),
        attendancePercentage: 98.2,
      ),
      Student(
        id: '4',
        name: 'Ananya Desai',
        fatherName: 'Kunal Desai',
        className: 'Grade 8',
        rollNumber: '104',
        registrationDate: DateTime(2024, 3, 5),
        attendancePercentage: 94.7,
      ),
      Student(
        id: '5',
        name: 'Karan Mehta',
        fatherName: 'Arjun Mehta',
        className: 'Grade 12',
        rollNumber: '105',
        registrationDate: DateTime(2024, 1, 25),
        attendancePercentage: 91.3,
      ),
      Student(
        id: '6',
        name: 'Sneha Reddy',
        fatherName: 'Ravi Reddy',
        className: 'Grade 10',
        rollNumber: '106',
        registrationDate: DateTime(2024, 2, 15),
        attendancePercentage: 97.8,
      ),
      Student(
        id: '7',
        name: 'Vikram Joshi',
        fatherName: 'Amit Joshi',
        className: 'Grade 9',
        rollNumber: '107',
        registrationDate: DateTime(2024, 3, 1),
        attendancePercentage: 93.4,
      ),
      Student(
        id: '8',
        name: 'Neha Gupta',
        fatherName: 'Rahul Gupta',
        className: 'Grade 11',
        rollNumber: '108',
        registrationDate: DateTime(2024, 1, 30),
        attendancePercentage: 95.9,
      ),
    ]);

    // Filter and sort students
    final filteredStudents = useMemoized(() {
      var result = List<Student>.from(students.value);

      // Apply search filter
      if (searchController.text.isNotEmpty) {
        final searchTerm = searchController.text.toLowerCase();
        result = result.where((student) =>
            student.name.toLowerCase().contains(searchTerm) ||
            student.fatherName.toLowerCase().contains(searchTerm) ||
            student.rollNumber.contains(searchTerm) ||
            student.className.toLowerCase().contains(searchTerm)).toList();
      }

      // Apply class filter
      if (selectedClassFilter.value != null) {
        result = result
            .where((student) => student.className == selectedClassFilter.value)
            .toList();
      }

      // Apply sorting
      switch (sortBy.value) {
        case 'name':
          result.sort((a, b) => a.name.compareTo(b.name));
          break;
        case 'class':
          result.sort((a, b) => a.className.compareTo(b.className));
          break;
        case 'date':
          result.sort((a, b) => b.registrationDate.compareTo(a.registrationDate));
          break;
        case 'attendance':
          result.sort((a, b) => b.attendancePercentage.compareTo(a.attendancePercentage));
          break;
      }

      return result;
    }, [students.value, searchController.text, selectedClassFilter.value, sortBy.value]);

    // Available class filters
    final classFilters = useMemoized(() {
      final classes = students.value.map((s) => s.className).toSet().toList();
      classes.sort();
      return ['All', ...classes];
    }, [students.value]);

    return Scaffold(
      body: Stack(
        children: [
          // Animated Background
          _buildAnimatedBackground(),

          // Main Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                _buildHeader(context, students.value.length)
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: -0.2, end: 0),

                const SizedBox(height: 24),

                // Controls Bar
                _buildControlsBar(
                  context,
                  searchController,
                  selectedClassFilter,
                  sortBy,
                  classFilters,
                  isGridView,
                  selectedStudents,
                  filteredStudents,
                ).animate().fadeIn(delay: 200.ms),

                const SizedBox(height: 24),

                // Student List/Grid
                Expanded(
                  child: filteredStudents.isEmpty
                      ? _buildEmptyState(context)
                          .animate()
                          .fadeIn(delay: 400.ms)
                      : isGridView.value
                          ? _buildGridView(
                              context,
                              filteredStudents,
                              hoveredIndex,
                              selectedStudents,
                            )
                          : _buildListView(
                              context,
                              filteredStudents,
                              hoveredIndex,
                              selectedStudents,
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1E88E5).withOpacity(0.08),
            const Color(0xFF4CAF50).withOpacity(0.05),
            const Color(0xFFFFC107).withOpacity(0.03),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Abstract educational patterns
          Positioned(
            top: 50,
            right: 100,
            child: Icon(
              Icons.school_rounded,
              size: 200,
              color: const Color(0xFF1E88E5).withOpacity(0.03),
            ).animate(
              onPlay: (controller) => controller.repeat(reverse: true),
            ).slideY(
              duration: 10.seconds,
              begin: -0.1,
              end: 0.1,
              curve: Curves.easeInOut,
            ),
          ),
          Positioned(
            bottom: 100,
            left: 50,
            child: Icon(
              Icons.menu_book_rounded,
              size: 150,
              color: const Color(0xFF4CAF50).withOpacity(0.03),
            ).animate(
              onPlay: (controller) => controller.repeat(reverse: true),
            ).rotate(
              duration: 20.seconds,
              begin: -5,
              end: 5,
              curve: Curves.easeInOut,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, int studentCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1E88E5), Color(0xFF4CAF50)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.group_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Student Directory',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E88E5),
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      '$studentCount Students Registered',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.trending_up_rounded,
                color: const Color(0xFF4CAF50),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Overall Attendance: 95.2%',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E88E5),
                ),
              ),
            ],
          ),
        ).animate().scale(delay: 300.ms),
      ],
    );
  }

  Widget _buildControlsBar(
    BuildContext context,
    TextEditingController searchController,
    ValueNotifier<String?> selectedClassFilter,
    ValueNotifier<String> sortBy,
    List<String> classFilters,
    ValueNotifier<bool> isGridView,
    ValueNotifier<Set<String>> selectedStudents,
    List<Student> filteredStudents,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 25,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          // Search Field
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(
                      Iconsax.search_normal,
                      color: Colors.grey[500],
                      size: 20,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search students by name, class, or roll number...',
                        hintStyle: GoogleFonts.inter(
                          color: Colors.grey[500],
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      onChanged: (_) {},
                    ),
                  ),
                  if (searchController.text.isNotEmpty)
                    IconButton(
                      icon: Icon(
                        Iconsax.close_circle,
                        color: Colors.grey[500],
                        size: 20,
                      ),
                      onPressed: () {
                        searchController.clear();
                      },
                    ),
                ],
              ),
            ).animate().scaleX(
                  begin: 0.9,
                  end: 1,
                  duration: 600.ms,
                  curve: Curves.easeOutBack,
                ),
          ),

          const SizedBox(width: 16),

          // Class Filter Dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedClassFilter.value ?? 'All',
                items: classFilters.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedClassFilter.value = value == 'All' ? null : value;
                },
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1E88E5),
                ),
                icon: Icon(
                  Iconsax.arrow_down_1,
                  color: Colors.grey[500],
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Sort Dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: sortBy.value,
                items: [
                  DropdownMenuItem(
                    value: 'name',
                    child: Row(
                      children: [
                        Icon(Iconsax.sort, size: 16),
                        const SizedBox(width: 8),
                        Text('Sort by Name'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'class',
                    child: Row(
                      children: [
                        Icon(Iconsax.sort, size: 16),
                        const SizedBox(width: 8),
                        Text('Sort by Class'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'date',
                    child: Row(
                      children: [
                        Icon(Iconsax.sort, size: 16),
                        const SizedBox(width: 8),
                        Text('Sort by Date'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'attendance',
                    child: Row(
                      children: [
                        Icon(Iconsax.sort, size: 16),
                        const SizedBox(width: 8),
                        Text('Sort by Attendance'),
                      ],
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) sortBy.value = value;
                },
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1E88E5),
                ),
                icon: Icon(
                  Iconsax.arrow_down_1,
                  color: Colors.grey[500],
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // View Toggle
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                _buildViewToggleButton(
                  context: context,
                  icon: Iconsax.grid_1,
                  isActive: isGridView.value,
                  onTap: () => isGridView.value = true,
                ),
                _buildViewToggleButton(
                  context: context,
                  icon: Iconsax.row_vertical,
                  isActive: !isGridView.value,
                  onTap: () => isGridView.value = false,
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Selected Students Counter
          if (selectedStudents.value.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF1E88E5).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF1E88E5)),
              ),
              child: Row(
                children: [
                  Text(
                    '${selectedStudents.value.length} selected',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E88E5),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Icon(
                      Iconsax.close_circle,
                      color: const Color(0xFF1E88E5),
                      size: 20,
                    ),
                    onPressed: () {
                      selectedStudents.value = {};
                    },
                  ),
                ],
              ),
            ).animate().scale(),
        ],
      ),
    );
  }

  Widget _buildViewToggleButton({
    required BuildContext context,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1E88E5) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isActive ? Colors.white : Colors.grey[600],
          size: 20,
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottie/empty-state.json',
            width: 300,
            height: 300,
            repeat: true,
          ),
          const SizedBox(height: 32),
          Text(
            'No Students Found',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E88E5),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Try adjusting your search or filters',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E88E5),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Add New Student',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(
    BuildContext context,
    List<Student> students,
    ValueNotifier<int?> hoveredIndex,
    ValueNotifier<Set<String>> selectedStudents,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 25,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: students.length,
          itemBuilder: (context, index) {
            final student = students[index];
            final isSelected = selectedStudents.value.contains(student.id);
            final isHovered = hoveredIndex.value == index;

            return MouseRegion(
              onEnter: (_) => hoveredIndex.value = index,
              onExit: (_) => hoveredIndex.value = null,
              child: GestureDetector(
                onTap: () {
                  final newSelection = Set<String>.from(selectedStudents.value);
                  if (isSelected) {
                    newSelection.remove(student.id);
                  } else {
                    newSelection.add(student.id);
                  }
                  selectedStudents.value = newSelection;
                },
                child: AnimatedContainer(
                  duration: 300.ms,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF1E88E5).withOpacity(0.05)
                        : isHovered
                            ? Colors.grey[50]
                            : index.isOdd
                                ? Colors.grey[20]
                                : Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[100]!,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Selection Checkbox
                      AnimatedContainer(
                        duration: 200.ms,
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF1E88E5) : Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF1E88E5)
                                : Colors.grey[300]!,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check_rounded,
                                color: Colors.white,
                                size: 16,
                              )
                            : null,
                      ),

                      const SizedBox(width: 24),

                      // Student Avatar
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF1E88E5),
                              const Color(0xFF4CAF50),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            student.name.substring(0, 1),
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 24),

                      // Student Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              student.name,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E88E5),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Father: ${student.fatherName}',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Class Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _getClassColor(student.className),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          student.className,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(width: 24),

                      // Attendance Indicator
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${student.attendancePercentage}%',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: _getAttendanceColor(student.attendancePercentage),
                            ),
                          ),
                          Text(
                            'Attendance',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 24),

                      // Actions
                      if (isHovered || isSelected)
                        Row(
                          children: [
                            _buildActionButton(
                              icon: Iconsax.edit,
                              color: const Color(0xFF4CAF50),
                              onTap: () {},
                            ),
                            const SizedBox(width: 8),
                            _buildActionButton(
                              icon: Iconsax.trash,
                              color: const Color(0xFFF44336),
                              onTap: () {},
                            ),
                          ],
                        ).animate().fadeIn().scale(),
                    ],
                  ),
                ).animate(delay: (index * 100).ms).slideX(
                      begin: -0.5,
                      end: 0,
                      duration: 400.ms,
                      curve: Curves.easeOut,
                    ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGridView(
    BuildContext context,
    List<Student> students,
    ValueNotifier<int?> hoveredIndex,
    ValueNotifier<Set<String>> selectedStudents,
  ) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.2,
      ),
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        final isHovered = hoveredIndex.value == index;
        final isSelected = selectedStudents.value.contains(student.id);

        return MouseRegion(
          onEnter: (_) => hoveredIndex.value = index,
          onExit: (_) => hoveredIndex.value = null,
          child: GestureDetector(
            onTap: () {
              final newSelection = Set<String>.from(selectedStudents.value);
              if (isSelected) {
                newSelection.remove(student.id);
              } else {
                newSelection.add(student.id);
              }
              selectedStudents.value = newSelection;
            },
            child: AnimatedContainer(
              duration: 300.ms,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF1E88E5).withOpacity(0.05)
                    : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isHovered
                    ? [
                        BoxShadow(
                          color: const Color(0xFF1E88E5).withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ],
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF1E88E5)
                      : Colors.grey[200]!,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 20,
                    right: 20,
                    child: AnimatedContainer(
                      duration: 200.ms,
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF1E88E5) : Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF1E88E5)
                              : Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check_rounded,
                              color: Colors.white,
                              size: 16,
                            )
                          : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Student Avatar
                        Center(
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF1E88E5),
                                  const Color(0xFF4CAF50),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                student.name.substring(0, 1),
                                style: GoogleFonts.poppins(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          student.name,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E88E5),
                          
                          ),

                            overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          student.fatherName,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),

                            overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _getClassColor(student.className),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            student.className,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate(delay: (index * 100).ms).fadeIn().scale(
                  begin: Offset(0.8, 0.8),
                  end: Offset(1, 1),
                  duration: 400.ms,
                  curve: Curves.easeOutBack,
                ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Icon(
          icon,
          color: color,
          size: 20,
        ),
      ),
    );
  }

  Color _getClassColor(String className) {
    final colors = {
      'Kindergarten': const Color(0xFFFFC107),
      'Grade 1': const Color(0xFF2196F3),
      'Grade 2': const Color(0xFF4CAF50),
      'Grade 3': const Color(0xFF9C27B0),
      'Grade 4': const Color(0xFFF44336),
      'Grade 5': const Color(0xFFFF9800),
      'Grade 6': const Color(0xFF795548),
      'Grade 7': const Color(0xFF607D8B),
      'Grade 8': const Color(0xFF3F51B5),
      'Grade 9': const Color(0xFF00BCD4),
      'Grade 10': const Color(0xFF8BC34A),
      'Grade 11': const Color(0xFFE91E63),
      'Grade 12': const Color(0xFF9E9E9E),
    };
    return colors[className] ?? const Color(0xFF1E88E5);
  }

  Color _getAttendanceColor(double percentage) {
    if (percentage >= 95) return const Color(0xFF4CAF50);
    if (percentage >= 85) return const Color(0xFFFFC107);
    return const Color(0xFFF44336);
  }
}





// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:google_fonts/google_fonts.dart';

// // Model for Student Data
// class Student {
//   final String name;
//   final String fatherName;
//   final String className;
//   final String rollNumber;
//   final Color accentColor;

//   Student({
//     required this.name,
//     required this.fatherName,
//     required this.className,
//     required this.rollNumber,
//     required this.accentColor,
//   });
// }

// class StudentListScreen extends StatefulWidget {
//   const StudentListScreen({super.key});

//   @override
//   State<StudentListScreen> createState() => _StudentListScreenState();
// }

// class _StudentListScreenState extends State<StudentListScreen> {
//   final TextEditingController _searchController = TextEditingController();
  
//   // Mock Data
//   final List<Student> _allStudents = [
//     Student(name: "Arjun Sharma", fatherName: "Rajesh Sharma", className: "Grade 10", rollNumber: "1001", accentColor: Colors.blue),
//     Student(name: "Sara Khan", fatherName: "Ahmed Khan", className: "Grade 12", rollNumber: "1205", accentColor: Colors.purple),
//     Student(name: "Liam Wilson", fatherName: "Robert Wilson", className: "Grade 8", rollNumber: "0812", accentColor: Colors.orange),
//     Student(name: "Priya Patel", fatherName: "Vikram Patel", className: "Grade 11", rollNumber: "1140", accentColor: Colors.pink),
//     Student(name: "Ethan Davis", fatherName: "John Davis", className: "Grade 9", rollNumber: "0922", accentColor: Colors.teal),
//     Student(name: "Anya Taylor", fatherName: "Chris Taylor", className: "Grade 10", rollNumber: "1044", accentColor: Colors.indigo),
//   ];

//   List<Student> _filteredStudents = [];

//   @override
//   void initState() {
//     super.initState();
//     _filteredStudents = _allStudents;
//   }

//   void _filterList(String query) {
//     setState(() {
//       _filteredStudents = _allStudents
//           .where((s) => s.name.toLowerCase().contains(query.toLowerCase()) || 
//                         s.rollNumber.contains(query))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F7FB),
//       body: Stack(
//         children: [
//           // Background Decoration
//           Positioned(
//             top: -100,
//             right: -100,
//             child: CircleAvatar(radius: 200, backgroundColor: Colors.blue.withOpacity(0.05)),
//           ),
          
//           Column(
//             children: [
//               _buildHeader(),
//               Expanded(
//                 child: _filteredStudents.isEmpty 
//                   ? _buildEmptyState() 
//                   : _buildStudentGrid(),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.all(40),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.8),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20)],
//       ),
//       child: Row(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Student Directory",
//                 style: GoogleFonts.poppins(
//                   fontSize: 32, 
//                   fontWeight: FontWeight.bold, 
//                   color: const Color(0xFF1A237E)
//                 ),
//               ),
//               Text(
//                 "Managing ${_allStudents.length} total students",
//                 style: GoogleFonts.inter(fontSize: 16, color: Colors.grey[600]),
//               ),
//             ],
//           ),
//           const Spacer(),
//           // Search Bar
//           Container(
//             width: 400,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: Colors.grey[200]!),
//             ),
//             child: TextField(
//               controller: _searchController,
//               onChanged: _filterList,
//               decoration: const InputDecoration(
//                 hintText: "Search by name or roll number...",
//                 prefixIcon: Icon(Icons.search, color: Colors.blue),
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(vertical: 15),
//               ),
//             ),
//           ),
//           const SizedBox(width: 20),
//           ElevatedButton.icon(
//             onPressed: () {},
//             icon: const Icon(Icons.filter_list),
//             label: const Text("Filters"),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.white,
//               foregroundColor: Colors.blue,
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//               side: const BorderSide(color: Color(0xFFBBDEFB)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStudentGrid() {
//     return GridView.builder(
//       padding: const EdgeInsets.all(40),
//       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//         maxCrossAxisExtent: 400,
//         mainAxisExtent: 200,
//         crossAxisSpacing: 30,
//         mainAxisSpacing: 30,
//       ),
//       itemCount: _filteredStudents.length,
//       itemBuilder: (context, index) {
//         final student = _filteredStudents[index];
//         return StudentCard(student: student)
//             .animate(delay: (100 * index).ms)
//             .fadeIn(duration: 500.ms)
//             .moveY(begin: 20, end: 0);
//       },
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.person_search_rounded, size: 100, color: Colors.grey[300]),
//           const SizedBox(height: 20),
//           Text(
//             "No students found",
//             style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey[400]),
//           ),
//         ],
//       ).animate().fadeIn(),
//     );
//   }
// }

// class StudentCard extends StatefulWidget {
//   final Student student;
//   const StudentCard({super.key, required this.student});

//   @override
//   State<StudentCard> createState() => _StudentCardState();
// }

// class _StudentCardState extends State<StudentCard> {
//   bool _isHovered = false;

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => _isHovered = true),
//       onExit: (_) => setState(() => _isHovered = false),
//       cursor: SystemMouseCursors.click,
//       child: AnimatedContainer(
//         duration: 200.ms,
//         padding: const EdgeInsets.all(24),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(24),
//           border: Border.all(
//             color: _isHovered ? widget.student.accentColor.withOpacity(0.5) : Colors.transparent,
//             width: 2,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: _isHovered 
//                   ? widget.student.accentColor.withOpacity(0.1) 
//                   : Colors.black.withOpacity(0.03),
//               blurRadius: _isHovered ? 30 : 10,
//               offset: Offset(0, _isHovered ? 10 : 4),
//             )
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 28,
//                   backgroundColor: widget.student.accentColor.withOpacity(0.1),
//                   child: Text(
//                     widget.student.name[0],
//                     style: TextStyle(color: widget.student.accentColor, fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.student.name,
//                         style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF2C3E50)),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       Text(
//                         "Roll No: ${widget.student.rollNumber}",
//                         style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[500], fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[300]),
//               ],
//             ),
//             const Spacer(),
//             const Divider(height: 32),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildInfoTag(Icons.school_outlined, widget.student.className),
//                 _buildInfoTag(Icons.family_restroom_outlined, widget.student.fatherName),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoTag(IconData icon, String label) {
//     return Row(
//       children: [
//         Icon(icon, size: 16, color: Colors.blueGrey[300]),
//         const SizedBox(width: 6),
//         Text(
//           label,
//           style: GoogleFonts.inter(fontSize: 13, color: Colors.blueGrey[600], fontWeight: FontWeight.w500),
//         ),
//       ],
//     );
//   }
// }