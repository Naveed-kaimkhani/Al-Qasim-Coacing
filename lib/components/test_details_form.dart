import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/components/section_card.dart';

class TestDetailsForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool isSaved;
  final VoidCallback onSave;

  const TestDetailsForm({
    super.key,
    required this.formKey,
    required this.isSaved,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Test Details",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 24),
          Form(
            key: formKey,
            child: Column(
              children: [
                // reuse your _buildDetailField here
              ],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onSave,
            icon: Icon(isSaved ? Icons.check : Icons.save),
            label: Text(isSaved ? "Saved" : "Save Details"),
          ),
        ],
      ),
    );
  }
}
