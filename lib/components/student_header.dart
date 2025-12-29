import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// class StudentHeader extends StatelessWidget {
//   final int totalStudents;
//   final TextEditingController controller;
//   final ValueChanged<String> onSearch;

//   const StudentHeader({
//     super.key,
//     required this.totalStudents,
//     required this.controller,
//     required this.onSearch,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(40),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.9),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20)
//         ],
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
//                   color: const Color(0xFF1A237E),
//                 ),
//               ),
//               Text(
//                 "Managing $totalStudents total students",
//                 style: GoogleFonts.inter(color: Colors.grey[600]),
//               ),
//             ],
//           ),
//           const Spacer(),
//           SearchBar(controller: controller, ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentListHeader extends StatelessWidget {
  final int totalStudents;
  final TextEditingController searchController;
  final ValueChanged<String> onSearch;
  final VoidCallback onFilterTap;

  const StudentListHeader({
    super.key,
    required this.totalStudents,
    required this.searchController,
    required this.onSearch,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        children: [
          _TitleSection(totalStudents: totalStudents),
          const Spacer(),
          _SearchBar(
            controller: searchController,
            onSearch: onSearch,
          ),
          const SizedBox(width: 20),
          _FilterButton(onTap: onFilterTap),
        ],
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  final int totalStudents;

  const _TitleSection({required this.totalStudents});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Student Directory",
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A237E),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Managing $totalStudents total students",
          style: GoogleFonts.inter(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSearch;

  const _SearchBar({
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TextField(
        controller: controller,
        onChanged: onSearch,
        decoration: const InputDecoration(
          hintText: "Search by name or roll number...",
          prefixIcon: Icon(Icons.search, color: Colors.blue),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final VoidCallback onTap;

  const _FilterButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: const Icon(Icons.filter_list),
      label: const Text("Filters"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: const BorderSide(color: Color(0xFFBBDEFB)),
        elevation: 0,
      ),
    );
  }
}
