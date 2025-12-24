// lib/styles/text_styles.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // Poppins Font Family (Modern, Clean)
  static TextStyle poppinsDisplayLarge(Color color) {
    return GoogleFonts.poppins(
      fontSize: 48,
      fontWeight: FontWeight.w800,
      color: color,
      letterSpacing: -0.5,
    );
  }

  static TextStyle poppinsHeadline(Color color) {
    return GoogleFonts.poppins(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      color: color,
      letterSpacing: 0,
    );
  }

  static TextStyle poppinsTitleLarge(Color color) {
    return GoogleFonts.poppins(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: color,
      letterSpacing: 0.15,
    );
  }

  static TextStyle poppinsTitleMedium(Color color) {
    return GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: color,
      letterSpacing: 0.1,
    );
  }

  static TextStyle poppinsButton(Color color) {
    return GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: color,
      letterSpacing: 0.8,
    );
  }

  // Inter Font Family (Excellent for UI/Forms)
  static TextStyle interBodyLarge(Color color) {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color,
      letterSpacing: 0.3,
    );
  }

  static TextStyle interBodyMedium(Color color) {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: color,
      letterSpacing: 0.25,
    );
  }

  static TextStyle interLabel(Color color) {
    return GoogleFonts.inter(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: color,
      letterSpacing: 0.4,
    );
  }

  static TextStyle interTextField(Color color) {
    return GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: color,
      letterSpacing: 0.3,
    );
  }

  // Playfair Display (Elegant, for headings)
  static TextStyle playfairDisplay(Color color) {
    return GoogleFonts.playfairDisplay(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: color,
      fontStyle: FontStyle.italic,
    );
  }

  // Montserrat (Professional)
  static TextStyle montserratTitle(Color color) {
    return GoogleFonts.montserrat(
      fontSize: 30,
      fontWeight: FontWeight.w700,
      color: color,
      letterSpacing: 1.2,
    );
  }

  // Nunito Sans (Friendly, Rounded)
  static TextStyle nunitoBody(Color color) {
    return GoogleFonts.nunito(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: color,
      letterSpacing: 0.2,
    );
  }
}