import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextDesign extends StatelessWidget {
  MyTextDesign(
      {super.key,
      required this.text,
      required this.fontSize,
      this.fontColor,
      this.textAlign,
      this.textOverflow,
      this.maxLines,
      this.fontWeight});
  final String text;
  final double fontSize;
  final Color? fontColor;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      maxLines: maxLines,
      style: GoogleFonts.comfortaa(
          fontSize: fontSize, color: fontColor, fontWeight: fontWeight),
      textAlign: textAlign,
    );
  }
}
