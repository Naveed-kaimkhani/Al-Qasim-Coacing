import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// Model for Monthly Fee Record
class MonthlyFee {
  final String id;
  final String month;
  final String year;
  final double amount;
  bool isPaid;
   DateTime dueDate;
   DateTime? paymentDate;
   String paymentMethod;

  MonthlyFee({
    required this.id,
    required this.month,
    required this.year,
    required this.amount,
    required this.isPaid,
    required this.dueDate,
    this.paymentDate,
    this.paymentMethod = '',
  });
}

class StudentFeeScreen extends StatefulWidget {
  final String studentName;
  final String className;
  final String rollNumber;
  
  const StudentFeeScreen({
    super.key,
    required this.studentName,
    required this.className,
    required this.rollNumber,
  });

  @override
  State<StudentFeeScreen> createState() => _StudentFeeScreenState();
}

class _StudentFeeScreenState extends State<StudentFeeScreen> {
  int _currentFilter = 0; // 0: All, 1: Paid, 2: Unpaid
  final double _monthlyFee = 2500.0;
  
  // Mock Data - Monthly fees for current year
  final List<MonthlyFee> _monthlyFees = [
    MonthlyFee(
      id: "1",
      month: "January",
      year: "2024",
      amount: 2500,
      isPaid: true,
      dueDate: DateTime(2024, 1, 10),
      paymentDate: DateTime(2024, 1, 5),
      paymentMethod: "Online",
    ),
    MonthlyFee(
      id: "2",
      month: "February",
      year: "2024",
      amount: 2500,
      isPaid: true,
      dueDate: DateTime(2024, 2, 10),
      paymentDate: DateTime(2024, 2, 8),
      paymentMethod: "Cash",
    ),
    MonthlyFee(
      id: "3",
      month: "March",
      year: "2024",
      amount: 2500,
      isPaid: false,
      dueDate: DateTime(2024, 3, 10),
    ),
    MonthlyFee(
      id: "4",
      month: "April",
      year: "2024",
      amount: 2500,
      isPaid: false,
      dueDate: DateTime(2024, 4, 10),
    ),
    MonthlyFee(
      id: "5",
      month: "May",
      year: "2024",
      amount: 2500,
      isPaid: true,
      dueDate: DateTime(2024, 5, 10),
      paymentDate: DateTime(2024, 5, 3),
      paymentMethod: "Bank Transfer",
    ),
    MonthlyFee(
      id: "6",
      month: "June",
      year: "2024",
      amount: 2500,
      isPaid: false,
      dueDate: DateTime(2024, 6, 10),
    ),
    MonthlyFee(
      id: "7",
      month: "July",
      year: "2024",
      amount: 2500,
      isPaid: true,
      dueDate: DateTime(2024, 7, 10),
      paymentDate: DateTime(2024, 7, 9),
      paymentMethod: "Online",
    ),
    MonthlyFee(
      id: "8",
      month: "August",
      year: "2024",
      amount: 2500,
      isPaid: true,
      dueDate: DateTime(2024, 8, 10),
      paymentDate: DateTime(2024, 8, 1),
      paymentMethod: "Card",
    ),
    MonthlyFee(
      id: "9",
      month: "September",
      year: "2024",
      amount: 2500,
      isPaid: false,
      dueDate: DateTime(2024, 9, 10),
    ),
    MonthlyFee(
      id: "10",
      month: "October",
      year: "2024",
      amount: 2500,
      isPaid: true,
      dueDate: DateTime(2024, 10, 10),
      paymentDate: DateTime(2024, 10, 5),
      paymentMethod: "Online",
    ),
    MonthlyFee(
      id: "11",
      month: "November",
      year: "2024",
      amount: 2500,
      isPaid: false,
      dueDate: DateTime(2024, 11, 10),
    ),
    MonthlyFee(
      id: "12",
      month: "December",
      year: "2024",
      amount: 2500,
      isPaid: true,
      dueDate: DateTime(2024, 12, 10),
      paymentDate: DateTime(2024, 12, 1),
      paymentMethod: "Cash",
    ),
  ];

  List<MonthlyFee> _filteredFees = [];

  @override
  void initState() {
    super.initState();
    _filteredFees = _monthlyFees;
  }

  void _togglePaymentStatus(MonthlyFee fee) {
    setState(() {
      fee.isPaid = !fee.isPaid;
      if (fee.isPaid) {
        fee.paymentDate = DateTime.now();
      } else {
        fee.paymentDate = null;
        fee.paymentMethod = '';
      }
    });
  }

  void _applyFilter(int filter) {
    setState(() {
      _currentFilter = filter;
      switch (filter) {
        case 1: // Paid only
          _filteredFees = _monthlyFees.where((fee) => fee.isPaid).toList();
          break;
        case 2: // Unpaid only
          _filteredFees = _monthlyFees.where((fee) => !fee.isPaid).toList();
          break;
        default: // All
          _filteredFees = _monthlyFees;
          break;
      }
    });
  }

  double get _totalPaid => _monthlyFees
      .where((fee) => fee.isPaid)
      .fold(0.0, (sum, fee) => sum + fee.amount);

  double get _totalUnpaid => _monthlyFees
      .where((fee) => !fee.isPaid)
      .fold(0.0, (sum, fee) => sum + fee.amount);

  int get _paidMonthsCount => _monthlyFees.where((fee) => fee.isPaid).length;
  int get _unpaidMonthsCount => _monthlyFees.where((fee) => !fee.isPaid).length;

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
              backgroundColor: const Color(0xFF7209B7).withOpacity(0.05),
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
                    
                    // Right Panel - Monthly Records
                    Expanded(
                      flex: 2,
                      child: _buildMonthlyRecordsPanel(),
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
                "Monthly Fee Records",
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
                  backgroundColor: const Color(0xFF7209B7).withOpacity(0.1),
                  child: Text(
                    widget.studentName[0],
                    style: const TextStyle(
                      color: Color(0xFF7209B7),
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
              const Icon(Icons.summarize_outlined, color: Color(0xFF7209B7)),
              const SizedBox(width: 12),
              Text(
                "Fee Summary",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A237E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          // const SizedBox(height: 20),
          
          Row(
            children: [
              Expanded(
                child: _buildMiniStatCard(
                  "Paid Months",
                  _paidMonthsCount.toString(),
                  const Color(0xFF4CAF50),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMiniStatCard(
                  "Unpaid Months",
                  _unpaidMonthsCount.toString(),
                  const Color(0xFFFF6B6B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          _buildStatCard(
            "Total Paid",
            "${_totalPaid.toStringAsFixed(0)}",
            Icons.check_circle_rounded,
            const Color(0xFF4CAF50),
          ),
          const SizedBox(height: 20),
          
          _buildStatCard(
            "Total Unpaid",
            "${_totalUnpaid.toStringAsFixed(0)}",
            Icons.pending_actions_rounded,
            const Color(0xFFFF6B6B),
          ),
          const SizedBox(height: 32),
          
          // Filters
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Filter Months",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildFilterButton("All", 0),
                  _buildFilterButton("Paid", 1),
                  _buildFilterButton("Unpaid", 2),
                ],
              ),
            ],
          ),
          const Spacer(),
          
          // Year Summary
          // Container(
          //   padding: const EdgeInsets.all(16),
          //   decoration: BoxDecoration(
          //     color: const Color(0xFFF5F7FB),
          //     borderRadius: BorderRadius.circular(16),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             "2024 Summary",
          //             style: GoogleFonts.inter(
          //               fontSize: 12,
          //               color: Colors.grey[600],
          //             ),
          //           ),
          //           Text(
          //             "12 Months",
          //             style: GoogleFonts.poppins(
          //               fontSize: 14,
          //               fontWeight: FontWeight.w600,
          //               color: const Color(0xFF1A237E),
          //             ),
          //           ),
          //         ],
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.end,
          //         children: [
          //           Text(
          //             "Completion",
          //             style: GoogleFonts.inter(
          //               fontSize: 12,
          //               color: Colors.grey[600],
          //             ),
          //           ),
          //           Text(
          //             "${((_paidMonthsCount / 12) * 100).toStringAsFixed(0)}%",
          //             style: GoogleFonts.poppins(
          //               fontSize: 24,
          //               fontWeight: FontWeight.bold,
          //               color: const Color(0xFF4CAF50),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
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

  Widget _buildMiniStatCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 11,
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
    );
  }

  Widget _buildFilterButton(String label, int index) {
    final isSelected = _currentFilter == index;
    return FilterChip(
      label: Text(label),
      labelStyle: GoogleFonts.inter(
        color: isSelected ? Colors.white : const Color(0xFF7209B7),
        fontWeight: FontWeight.w500,
      ),
      selected: isSelected,
      onSelected: (_) => _applyFilter(index),
      backgroundColor: const Color(0xFF7209B7).withOpacity(0.1),
      selectedColor: const Color(0xFF7209B7),
      checkmarkColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: const Color(0xFF7209B7).withOpacity(0.2)),
      ),
    );
  }

  Widget _buildMonthlyRecordsPanel() {
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
                const Icon(Icons.calendar_month_rounded, color: Color(0xFF7209B7)),
                const SizedBox(width: 12),
                Text(
                  "Monthly Records - 2024",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A237E),
                  ),
                ),
                const Spacer(),
                Text(
                  "${_filteredFees.length} months",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          // Monthly Records Grid
          Expanded(
            child: _filteredFees.isEmpty
                ? _buildEmptyState()
                : GridView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: _filteredFees.length,
                    itemBuilder: (context, index) {
                      final fee = _filteredFees[index];
                      return _buildMonthCard(fee);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthCard(MonthlyFee fee) {
    final isOverdue = !fee.isPaid && fee.dueDate.isBefore(DateTime.now());
    
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
          color: isOverdue 
              ? const Color(0xFFFF6B6B).withOpacity(0.3)
              : fee.isPaid 
                  ? const Color(0xFF4CAF50).withOpacity(0.3)
                  : Colors.transparent,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                fee.month,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C3E50),
                ),
              ),
              // Status Indicator
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: fee.isPaid ? const Color(0xFF4CAF50) : const Color(0xFFFF6B6B),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Amount
          Text(
            "${fee.amount.toStringAsFixed(0)}",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A237E),
            ),
          ),
          const SizedBox(height: 8),
          
          // Due Date
          Text(
            "Due: ${DateFormat('dd MMM').format(fee.dueDate)}",
            style: GoogleFonts.inter(
              fontSize: 12,
              color: isOverdue ? const Color(0xFFFF6B6B) : Colors.grey[600],
              fontWeight: isOverdue ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 12),
          
          // Payment Info
          if (fee.isPaid && fee.paymentDate != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Paid: ${DateFormat('dd MMM').format(fee.paymentDate!)}",
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: const Color(0xFF4CAF50),
                  ),
                ),
                if (fee.paymentMethod.isNotEmpty)
                  Text(
                    fee.paymentMethod,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
              ],
            ),
          
          const Spacer(),
          
          // Toggle Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _togglePaymentStatus(fee),
              style: ElevatedButton.styleFrom(
                backgroundColor: fee.isPaid
                    ? const Color(0xFF4CAF50).withOpacity(0.1)
                    : const Color(0xFFFF6B6B).withOpacity(0.1),
                foregroundColor: fee.isPaid ? const Color(0xFF4CAF50) : const Color(0xFFFF6B6B),
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: Text(
                fee.isPaid ? "Mark Unpaid" : "Mark Paid",
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.filter_alt_off_rounded, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 20),
          Text(
            "No months found",
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